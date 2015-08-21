class RenameEventsRelationTables < ActiveRecord::Migration
  def change
    rename_table :events_weeks, :items_weeks
    rename_table :events_personas, :items_personas
    rename_table :categories_events, :categories_items
  end
end
