class AddFullAddressToPlace < ActiveRecord::Migration
  def change
    add_column :places, :full_address, :string
  end
end
