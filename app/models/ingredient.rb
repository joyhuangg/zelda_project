class Ingredient < ApplicationRecord
  has_many :ingredient_users
  has_many :users, through: :ingredient_users
  has_many :ingredient_recipes
  has_many :recipes, through: :ingredient_recipes
  has_many :ingredient_categories
  has_many :categories, through: :ingredient_categories
end
