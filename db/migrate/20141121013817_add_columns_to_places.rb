class AddColumnsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :neighborhood, :string
    add_column :places, :city, :string
    add_column :places, :street_number, :string
  end
end
