class RenameOrderFromWeek < ActiveRecord::Migration
  def change
  	rename_column :weeks, :order, :organizer_id
  end
end
