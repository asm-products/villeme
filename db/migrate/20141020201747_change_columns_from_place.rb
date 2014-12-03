class ChangeColumnsFromPlace < ActiveRecord::Migration
  def change
  	rename_column :places, :neighborhood, :neighborhood_name
  	rename_column :places, :city, :city_name
  	rename_column :events, :neighborhood, :neighborhood_name
  	rename_column :events, :city, :city_name  	
  end
end
