class RenameEventColumnsToItem < ActiveRecord::Migration
  def change
    rename_column :items_weeks, :event_id, :item_id
    rename_column :items_personas, :event_id, :item_id
  end
end
