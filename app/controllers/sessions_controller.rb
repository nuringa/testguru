class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:request_path]
    else
      flash.now[:alert] = 'Verify you Email and Password please'
      render :new
    end
  end
end
