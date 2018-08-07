class UsersController < ApplicationController
  include ApplicationHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id]= @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = current_user
    if !logged_in?
      redirect_to root_path
    end
  end

  def edit
    @user = current_user
    if !logged_in
      redirect_to root_path
    end
  end

  private


  def user_params
    params.require(:user).permit(:username, :password, :email)
  end



end
