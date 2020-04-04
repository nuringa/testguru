class CreateJoinTableTestUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tests, :users
  end
end
