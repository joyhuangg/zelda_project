class Recipe < ApplicationRecord
  has_many :ingredient_recipes
  has_many :ingredients, through: :ingredient_recipes
  has_many :users, through: :ingredients
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  validates :name, presence:true, uniqueness:true

  #NEEDS REFACTORING
  #maybe have it return an array of ingredients and categories needed for a recipe
  def print_ingredients
    pastel = Pastel.new
    puts pastel.red.underline("Ingredient(s) needed for #{self.name}")
    self.ingredient_recipes.each do |recipe_ingredient|
      if recipe_ingredient.ingredient == nil
        ingredient = "Any #{recipe_ingredient.category.name}"
      else
        ingredient = recipe_ingredient.ingredient.name
      end
      puts ingredient
    end
  end


  #check to see if this works
  #might not need these
  def general_ingredient_recipes
    self.ingredient_recipes.select {|ingredient_recipe| ingredient_recipe.ingredient == nil}
  end

  def specific_ingredient_recipes
    self.ingredient_recipes.select {|ingredient_recipe| ingredient_recipe.ingredient != nil}
  end
end
