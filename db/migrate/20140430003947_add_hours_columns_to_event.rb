class AddHoursColumnsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :hour_start_second, :time
    add_column :events, :hour_start_third, :time
    add_column :events, :hour_start_fourth, :time
    add_column :events, :hour_start_fifth, :time
    add_column :events, :hour_start_sixth, :time
  end
end
