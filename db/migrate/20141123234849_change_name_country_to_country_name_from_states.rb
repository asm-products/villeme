class ChangeNameCountryToCountryNameFromStates < ActiveRecord::Migration
  def change
    rename_column :states, :country, :country_name
    add_column :states, :slug, :string
  end
end
