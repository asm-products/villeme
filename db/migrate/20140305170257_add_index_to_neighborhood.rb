class AddIndexToNeighborhood < ActiveRecord::Migration
  def change
    add_index :neighborhoods, :city_id
  end
end
