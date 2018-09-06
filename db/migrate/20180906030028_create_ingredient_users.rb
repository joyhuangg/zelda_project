class CreateIngredientUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredient_users do |t|
      t.integer :ingredient_id
      t.integer :user_id
      t.integer :quantity

      t.timestamps
    end
  end
end
