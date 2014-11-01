class AddAddressAndDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :address, :string
    add_column :events, :date, :date
    add_column :events, :hour, :time
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
  end
end
