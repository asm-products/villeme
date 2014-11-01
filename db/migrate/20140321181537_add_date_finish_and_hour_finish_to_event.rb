class AddDateFinishAndHourFinishToEvent < ActiveRecord::Migration
  def change
    add_column :events, :date_finish, :date
    add_column :events, :hour_finish, :time
  end
end
