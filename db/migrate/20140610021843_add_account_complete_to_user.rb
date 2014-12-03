class AddAccountCompleteToUser < ActiveRecord::Migration
  def change
  	add_column :users, :account_complete, :boolean, default: false
  end
end
