class Users::SessionsController < Devise::SessionsController
  def create
    super
    flash[:notice] = t('.wellcome', name: current_user.first_name)
  end
end