class CreateEventsWeeks < ActiveRecord::Migration
  def change
    create_table :events_weeks, id: false do |t|
      t.integer :event_id
      t.integer :week_id
    end
  end
end
