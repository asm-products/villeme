class RemoveColumnsFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :neighborhood_id, :string
    remove_column :events, :neighborhood_name, :string
    remove_column :events, :city_name, :string
    remove_column :events, :cross_street, :string
  end
end
