class ChangeNameOfColumnsFromCities < ActiveRecord::Migration
  def change
    rename_column :cities, :country, :country_name
    rename_column :cities, :state, :state_name
  end
end
