class AddReferenceToUsersAuthors < ActiveRecord::Migration[6.0]
  def change
    # c использованием add_reference:
    # add_reference :tests, :author, references: :users
    # add_foreign_key :tests, :users, column: :author_id

    change_table :tests do |t|
      t.references :author, references: :users, foreign_key: { to_table: :users}
    end
  end
end
