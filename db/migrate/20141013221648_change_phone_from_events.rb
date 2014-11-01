class ChangePhoneFromEvents < ActiveRecord::Migration
  def change
  	change_column :events, :phone, :string
  end
end
