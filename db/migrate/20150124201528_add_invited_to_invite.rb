class AddInvitedToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :invited, :boolean, default: false
  end
end
