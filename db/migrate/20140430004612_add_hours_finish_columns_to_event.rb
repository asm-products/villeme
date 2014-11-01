class AddHoursFinishColumnsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :hour_finish_second, :time
    add_column :events, :hour_finish_third, :time
    add_column :events, :hour_finish_fourth, :time
    add_column :events, :hour_finish_fifth, :time
    add_column :events, :hour_finish_sixth, :time
  end
end
