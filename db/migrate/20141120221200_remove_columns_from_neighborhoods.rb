class RemoveColumnsFromNeighborhoods < ActiveRecord::Migration
  def change
    remove_column :neighborhoods, :city_id, :string
  end
end
