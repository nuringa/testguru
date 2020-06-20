class AddTimestampsToBadgesUsers < ActiveRecord::Migration[6.0]
  def change
    add_timestamps :badges_users
  end
end
