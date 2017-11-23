class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
