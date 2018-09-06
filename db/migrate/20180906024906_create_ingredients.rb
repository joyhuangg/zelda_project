class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.integer :calories
      t.string :name
      t.float :hearts
      t.string :cooked_effect

      t.timestamps
    end
  end
end
