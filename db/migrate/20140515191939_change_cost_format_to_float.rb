class ChangeCostFormatToFloat < ActiveRecord::Migration
  def change
  	change_column :events, :cost, :float
  end
end
