class ChangeNameOfColumnsFromNeighborhoods < ActiveRecord::Migration
  def change
    rename_column :neighborhoods, :country, :country_name
    rename_column :neighborhoods, :state, :state_name
    rename_column :neighborhoods, :city, :city_name
  end
end
