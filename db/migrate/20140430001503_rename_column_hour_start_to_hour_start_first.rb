class RenameColumnHourStartToHourStartFirst < ActiveRecord::Migration
  def change
  	rename_column :events, :hour_start, :hour_start_first
  	rename_column :events, :hour_finish, :hour_finish_first
  end
end
