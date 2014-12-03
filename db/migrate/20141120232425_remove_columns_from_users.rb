class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :city_id, :string
    remove_column :users, :neighborhood_id, :string
  end
end
