class BadgesUsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @badges = Badge.all
    @badges_users = current_user.badges
  end
end
