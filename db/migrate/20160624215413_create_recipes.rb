class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :page
      t.string :dish
      t.string :ingredient_1
      t.string :ingredient_2
      t.string :ingredient_3

      t.timestamps null: false
    end
  end
end
