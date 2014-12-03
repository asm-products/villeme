class AddAcceptedAtToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :accepted_at, :date
  end
end
