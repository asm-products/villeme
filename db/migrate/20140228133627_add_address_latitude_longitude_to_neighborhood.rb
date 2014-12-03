class AddAddressLatitudeLongitudeToNeighborhood < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :address, :string
    add_column :neighborhoods, :latitude, :float
    add_column :neighborhoods, :longitude, :float
  end
end
