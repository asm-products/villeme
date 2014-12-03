class ChangeNameOfColumnsFromEvents < ActiveRecord::Migration
  def change
    rename_column :events, :country, :country_name
    rename_column :events, :state, :state_name
    rename_column :events, :city, :city_name
    rename_column :events, :neighborhood, :neighborhood_name
  end
end
