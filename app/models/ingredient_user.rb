class IngredientUser < ApplicationRecord
  belongs_to :ingredient
  belongs_to :user
  validates :quantity, length: {minimum: 1}

  def use_ingredient
    if self.quantity == 1
      self.destroy
    else
      self.quantity = self.quantity - 1
      self.save
    end
  end
end
