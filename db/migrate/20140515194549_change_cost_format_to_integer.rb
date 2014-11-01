class ChangeCostFormatToInteger < ActiveRecord::Migration
  def change
  	change_column :events, :cost, :integer
  end
end
