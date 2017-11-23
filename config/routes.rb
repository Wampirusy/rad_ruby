Rails.application.routes.draw do
  scope 'rest/:model_name', controller: 'rest' do
    get '/', action: 'index'
    get '/:id', action: 'show'
    post '/', action: 'create'
    put '/:id', action: 'update'
    delete '/:id', action: 'destroy'
  end
end
