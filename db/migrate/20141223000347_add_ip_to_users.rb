class AddIpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ip, :string
  end
end
