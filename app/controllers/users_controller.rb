# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :find_user, only: [:show, :profile, :update_profile, :update_password, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User successfully created"
      redirect_to users_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def profile
  end

  def update_profile
    respond_to do |format|  
      if @user.update(user_params)
        flash.now[:notice] = "Profile updated successfully"
        format.js
      else
        flash.now[:errors] =  @user.errors.full_messages
        format.js
      end
    end
  end

  def change_password
    @pw = User.find(params[:id])
  end

  def update_password
    if @user.update_attribute(:password,params[:new_password])
      flash[:notice] = "Password updated successfully"
      redirect_to users_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to change_password_user_path(@user)
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :subcription, :subscription_email)
  end
end
