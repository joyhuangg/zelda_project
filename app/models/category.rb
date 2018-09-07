class Category < ApplicationRecord
  has_many :ingredient_categories
  has_many :ingredients, through: :ingredient_categories
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories

  validates :name, presence:true, uniqueness:true
end
