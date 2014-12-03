class ChangeNameOfColumnsFromPlaces < ActiveRecord::Migration
  def change
    rename_column :places, :country, :country_name
    rename_column :places, :state, :state_name
    rename_column :places, :city, :city_name
    rename_column :places, :neighborhood, :neighborhood_name
  end
end
