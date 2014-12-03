class ChangeDefaultValueOfLevel < ActiveRecord::Migration
  def change
  	change_column :users, :level_id, :integer, :default => 1
  end
end
