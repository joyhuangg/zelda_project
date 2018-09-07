class IngredientCategory < ApplicationRecord
  belongs_to :ingredient
  belongs_to :category

end
