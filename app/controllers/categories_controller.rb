class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def show
    find_category
  end

  def edit
    find_category
  end

  def update
    find_category
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
