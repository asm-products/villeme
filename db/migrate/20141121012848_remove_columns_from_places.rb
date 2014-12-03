class RemoveColumnsFromPlaces < ActiveRecord::Migration
  def change
    remove_column :places, :address, :string
    remove_column :places, :number, :string
    remove_column :places, :city_name, :string
    remove_column :places, :cross_street, :string
    remove_column :places, :neighborhood_name, :string
  end
end
