class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  private

  def after_sign_in_path_for(resource)
    if current_user.is_a?(Admin)
      (stored_location_for(resource) || admin_tests_path)
    else
      (stored_location_for(resource) || root_path)
    end
  end
end
