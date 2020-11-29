class AddTimeToTest < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :time, :integer
  end
end
