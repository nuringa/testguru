class SessionsController < ApplicationController

  skip_before_action :authenticate_user!, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have logged in'
      redirect_back_or(tests_path)
    else
      flash.now[:alert] = 'Verify you Email and Password please'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'You have logged out'
  end
end
