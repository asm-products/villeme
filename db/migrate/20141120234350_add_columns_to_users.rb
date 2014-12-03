class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :postal_code, :string
    add_column :users, :neighborhood, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :state_code, :string
    add_column :users, :country, :string
    add_column :users, :country_code, :string
    add_column :users, :street_number, :string
    add_column :users, :full_address, :string
  end
end
