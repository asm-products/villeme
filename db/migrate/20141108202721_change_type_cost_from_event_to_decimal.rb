class ChangeTypeCostFromEventToDecimal < ActiveRecord::Migration
  def change
    change_column :events, :cost, :decimal, precision: 8, scale: 2
  end
end
