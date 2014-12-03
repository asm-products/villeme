class AddColumnsToPlace < ActiveRecord::Migration
  def change
    add_column :places, :city, :string
    add_column :places, :country, :string
    add_column :places, :country_code, :string
    add_column :places, :cross_street, :string
    add_column :places, :postal_code, :string
    add_column :places, :state, :string
    add_column :places, :state_code, :string
    add_column :places, :formatted_address, :string
    add_column :places, :neighborhood, :string
  end
end
