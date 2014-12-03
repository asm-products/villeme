class AddPriceIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :price_id, :integer
    add_index :events, :price_id
  end
end
