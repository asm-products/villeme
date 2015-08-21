class RenameEventToItem < ActiveRecord::Migration
  def change
    rename_table :events, :items
  end
end
