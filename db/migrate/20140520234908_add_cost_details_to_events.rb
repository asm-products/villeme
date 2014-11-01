class AddCostDetailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :cost_details, :text
  end
end
