class ApplicationController < ActionController::Base

  helper_method :current_user,
                :logged_in?

  private

  def authenticate_user!
    unless current_user
      session[:forwarding_url] = request.original_url if request.get?
      redirect_to login_path, alert: 'Verify your Email and Password, please'
    end

    cookies[:email] = current_user&.email
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
end
