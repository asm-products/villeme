class AddAddressToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :address, :string
  end
end
