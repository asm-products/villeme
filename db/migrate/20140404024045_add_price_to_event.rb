class AddPriceToEvent < ActiveRecord::Migration
  def change
    add_column :events, :cost, :integer
  end
end
