class AddProfileInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_of_birth, :string
    add_column :users, :about, :text
    add_column :users, :gender, :string
  end
end
