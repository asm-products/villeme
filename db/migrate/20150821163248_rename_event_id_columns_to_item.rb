class RenameEventIdColumnsToItem < ActiveRecord::Migration
  def change
    rename_column :agenda_events, :event_id, :item_id
    rename_column :categories_items, :event_id, :item_id
    rename_column :tips, :event_id, :item_id
  end
end
