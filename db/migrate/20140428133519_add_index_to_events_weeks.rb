class AddIndexToEventsWeeks < ActiveRecord::Migration
  def change
  	add_index(:events_weeks, [:event_id, :week_id], :unique => true)
		add_index(:events_weeks, :week_id)
  end
end
