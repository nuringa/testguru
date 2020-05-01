class Users::SessionsController < Devise::SessionsController
  def create
    super
    flash[:notice] = "Wellcome, #{current_user.first_name}"
  end
end