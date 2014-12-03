class AddCityNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city_name, :string
  end
end
