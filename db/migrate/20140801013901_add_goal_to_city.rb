class AddGoalToCity < ActiveRecord::Migration
  def change
    add_column :cities, :goal, :integer
  end
end
