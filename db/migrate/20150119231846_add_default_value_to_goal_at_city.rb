class AddDefaultValueToGoalAtCity < ActiveRecord::Migration
  def change
    change_column_default :cities, :goal, 250
  end
end
