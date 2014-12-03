class AddColumnsToCities < ActiveRecord::Migration
  def change
    add_column :cities, :country, :string
    add_column :cities, :country_code, :string
    add_column :cities, :state, :string
    add_column :cities, :state_code, :string
  end
end
