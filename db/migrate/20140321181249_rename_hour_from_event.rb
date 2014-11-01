class RenameHourFromEvent < ActiveRecord::Migration
  def change
  	rename_column :events, :hour, :hour_start
  end
end
