class RestController < ApplicationController

  before_action :prepare_model, only: [:index, :show, :create, :update, :destroy]
  before_action :find_record, only: [:show, :update, :destroy]

  def index
   @res = @model_class

   @res = @res.where(permitted_where)
   @res = @res.limit(params[:limit].to_i) if params[:limit]
   @res = @res.offset(params[:offset].to_i) if params[:offset]

    render json: @res.all
  end

  def show
    render json: @res
  end

  def create
    if @res = @model_class.create(permitted_params)
      render json: @res
    else
      # invalid_resource!(@res)
    end
  end

  def update
    if @res.update_attributes(permitted_params)
      render json: @res
    else
      # invalid_resource!(@res)
    end
  end

  def destroy
    @res.destroy
    raise @res.errors[:base].to_s unless @res.errors[:base].empty?
    render json: { success: true }, status: 204
  end

  protected
  def permitted_where
    if params[:where]
      params[:where].permit(@model_class.column_names)
    end
  end

  def permitted_params
    params.permit(@model_class.column_names)
  end

  def get_model_name
    params[:model_name] || controller_name.classify
  end

  def prepare_model
    model_name = get_model_name

    raise "Model class not present" if model_name.nil? || model_name.strip == ""

    @model_class = model_name.classify.constantize

    raise "Model class is not ActiveRecord" unless @model_class < ActiveRecord::Base
  end

  def find_record
    @res = @model_class.find(params[@model_class.primary_key.to_sym])
  end
end