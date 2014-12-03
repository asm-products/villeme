class AddIndexToPlace < ActiveRecord::Migration
  def change
    add_index :places, :neighborhood_id
  end
end
