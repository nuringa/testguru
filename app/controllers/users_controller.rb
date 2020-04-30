class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'User sucessfully created'
      redirect_back_or(tests_path)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :password_digest)
  end
end
