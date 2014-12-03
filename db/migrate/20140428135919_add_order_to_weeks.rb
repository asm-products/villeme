class AddOrderToWeeks < ActiveRecord::Migration
  def change
    add_column :weeks, :order, :integer
  end
end
