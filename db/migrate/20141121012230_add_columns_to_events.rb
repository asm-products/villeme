class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :city, :string
    add_column :events, :neighborhood, :string
    add_column :events, :street_number, :string
  end
end
