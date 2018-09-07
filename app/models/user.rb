class User < ApplicationRecord
  has_many :ingredient_users
  has_many :ingredients, through: :ingredient_users
  has_many :ingredient_recipes, through: :ingredients
  has_many :recipes, through: :ingredient_recipes
  has_many :meals
  validates :first_name, presence:true
  validates :last_name, presence:true
  validates :email, presence:true, uniqueness:true
  validates :password, presence:true
  
  def name
    "#{self.first_name} #{self.last_name}"
  end

  def add_ingredientusers(ingredients)
    ingredients.each {|ingredient| IngredientUser.create(user_id: self.id, ingredient_id: ingredient.id)}
  end

  def show_user_ingredients
    if !self.ingredients.empty?
      pastel = Pastel.new
      puts pastel.red.underline("#{self.name}'s Inventory")
      puts pastel.magenta("Quantity - Item")
      self.ingredient_users.each {|ingredient_user| puts ingredient_user.quantity.to_s + " - " + pastel.yellow(ingredient_user.ingredient.name)}
    end
  end

  def has_ingredient_in_category?(category)
    self.ingredients.any?{|ingredient| ingredient.categories.include?(category)}
  end


  def valid_recipe?(recipe)
    recipe.ingredient_recipes.each do |recipe_ingredient|
      #search by category instead
      if recipe_ingredient.ingredient == nil
        category = recipe_ingredient.category
        if !has_ingredient_in_category?(category)
          return false
        end
      elsif !self.ingredients.include?(recipe_ingredient.ingredient)
        return false
      end
    end
    return true
  end

  def find_recipes
    Recipe.all.select {|recipe| valid_recipe?(recipe)}
  end

  def choose_ingredient_from_category(category)
    prompt = TTY::Prompt.new
    choices = []
    self.ingredients.each do |ingredient|
      if ingredient.categories.include?(category)
        choices.push({name: ingredient.name, value: ingredient})
      end
    end
    prompt.select("Select the ingredient to use for this recipe. (Use arrow keys, press Space to select and Enter to finish, and letter keys to filter)", choices, filter: true, per_page: 10)
  end

  def make_recipe(recipe)
    pastel = Pastel.new
    if valid_recipe?(recipe)
      system "open audio/link_cooking.mp3"
      sleep(4)
      puts pastel.yellow.underline("♬♪♩ Cooking #{recipe.name} ♬♪♩")
      sleep(2)
      Meal.create(user_id: self.id, recipe_id: recipe.id)
      recipe.ingredient_recipes.each do |recipe_ingredient|
        #when the ingredient column is nil, the category column holds category specifics
        if recipe_ingredient.ingredient == nil
          #helper function that prompts user to select from usable ingredients in the category
          #and returns the ingredient they chose
          ingredient = choose_ingredient_from_category(recipe_ingredient.category)
          puts pastel.cyan("Using a #{ingredient.name}")
          ingredient_user = IngredientUser.find_by(user_id: self.id , ingredient_id: ingredient.id)
          #helper function that either subtracts from the quantity or deletes the object
          ingredient_user.use_ingredient
        else
          ingredient = recipe_ingredient.ingredient
          puts pastel.cyan("Using a #{ingredient.name}")
          ingredient_user = IngredientUser.find_by(user_id: self.id , ingredient_id: ingredient.id)
          ingredient_user.use_ingredient
        end
      end
      puts "
           _....._
       _.:`.--|--.`:._
     .: .'\o  | o /'. '.
    // '.  \ o|  /  o '.\\
   //'._o'. \ |o/ o_.-'o\\
   || o '-.'.\|/.-' o   ||
   ||--o--o-->|<o-----o-||
   \\  o _.-'/|\'-._o  o//
    \\.-'  o/ |o\ o '-.//
     '.'.o / o|  \ o.'.'
       `-:/.__|__o\:-'
          `\"--=--\"`"
      puts pastel.blue.on_magenta("\n ۞۞۞ Congrats! You added #{recipe.name} to your meals! ۞۞۞")
    else
      puts pastel.red("I don't have the ingredients for that recipe")
      return
    end
    return
  end

  def print_meals
    pastel = Pastel.new
    puts pastel.cyan.underline("#{self.first_name}'s Dishes")
    self.meals.each {|meal| puts meal.recipe.name}
  end

end
