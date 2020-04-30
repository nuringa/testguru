class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :name, :string
    add_column :users, :password_digest, :string
    add_column :users, :email, :string, null: false
  end
end
