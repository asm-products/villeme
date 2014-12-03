class AddColumnsToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :state, :string
    add_column :neighborhoods, :state_code, :string
    add_column :neighborhoods, :country, :string
    add_column :neighborhoods, :country_code, :string
    add_column :neighborhoods, :city, :string
  end
end
