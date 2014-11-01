class AddInvitedToUser < ActiveRecord::Migration
  def change
  	add_column :users, :invited, :boolean, default: false
  end
end
