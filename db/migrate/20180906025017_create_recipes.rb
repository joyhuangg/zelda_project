class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :duration
      t.integer :calories
      t.string :image_url

      t.timestamps
    end
  end
end
