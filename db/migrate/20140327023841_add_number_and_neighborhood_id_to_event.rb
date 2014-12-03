class AddNumberAndNeighborhoodIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :number, :integer
    add_column :events, :neighborhood_id, :integer
  end
end
