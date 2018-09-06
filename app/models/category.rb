class Category < ApplicationRecord
  has_many :ingredient_categories
  has many :ingredients, through: :ingredient_categories
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories
end
