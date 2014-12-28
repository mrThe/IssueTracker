class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = :staff

    if @user.save
      flash[:notice] = "User #{@user.name} created!"
      redirect_to new_user_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
