class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def show
    find_user
  end

  def edit
    find_user
  end

  def update
    find_user
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :first_name, :last_name, :user_name, :password, :email)
  end
end
