class RenameColumnsAndTableAgenda < ActiveRecord::Migration
  def change
    rename_table :agenda_events, :agenda_items
    rename_column :agendas, :event_id, :item_id
  end
end
