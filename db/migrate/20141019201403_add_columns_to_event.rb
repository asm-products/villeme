class AddColumnsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :city, :string
    add_column :events, :country, :string
    add_column :events, :country_code, :string
    add_column :events, :cross_street, :string
    add_column :events, :postal_code, :string
    add_column :events, :state, :string
    add_column :events, :state_code, :string
    add_column :events, :formatted_address, :string
    add_column :events, :neighborhood, :string
  end
end
