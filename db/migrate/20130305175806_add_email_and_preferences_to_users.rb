class AddEmailAndPreferencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :preferences, :string
  end
end
