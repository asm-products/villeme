class AddLinkEmailAndPhoneToEvent < ActiveRecord::Migration
  def change
    add_column :events, :link, :string
    add_column :events, :email, :string
    add_column :events, :phone, :integer
  end
end
