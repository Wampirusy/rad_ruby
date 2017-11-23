class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :alias, null: false

      t.timestamps
    end

    add_index :categories, :alias, unique: true
  end
end
