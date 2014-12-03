class ChangeNameOfColumnsFromUser < ActiveRecord::Migration
  def change
    rename_column :users, :country, :country_name
    rename_column :users, :state, :state_name
    rename_column :users, :city, :city_name
    rename_column :users, :neighborhood, :neighborhood_name
  end
end
