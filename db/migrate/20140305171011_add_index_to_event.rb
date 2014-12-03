class AddIndexToEvent < ActiveRecord::Migration
  def change
    add_index :events, :place_id
    add_index :events, :user_id
  end
end
