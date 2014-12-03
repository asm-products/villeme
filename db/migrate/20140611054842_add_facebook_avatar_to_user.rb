class AddFacebookAvatarToUser < ActiveRecord::Migration
  def change
  	add_column :users, :facebook_avatar, :string
  end
end
