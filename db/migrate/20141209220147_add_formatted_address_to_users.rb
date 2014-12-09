class AddFormattedAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :formatted_address, :string
  end
end
