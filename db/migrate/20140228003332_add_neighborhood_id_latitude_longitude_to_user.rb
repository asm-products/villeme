class AddNeighborhoodIdLatitudeLongitudeToUser < ActiveRecord::Migration
  def change
    add_column :users, :neighborhood_id, :integer
    add_index :users, :neighborhood_id
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
