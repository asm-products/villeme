class AddTokenToUser < ActiveRecord::Migration
  def change
  	add_column :users, :token, :string, default: nil
  end
end
