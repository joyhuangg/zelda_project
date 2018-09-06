class Recipe < ApplicationRecord
  has_many :ingredient_recipes
  has_many :ingredients, through: :ingredient_recipes
  has_many :users, through: :ingredients
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
end
