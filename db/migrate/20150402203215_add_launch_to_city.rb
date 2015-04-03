class AddLaunchToCity < ActiveRecord::Migration
  def change
    add_column :cities, :launch, :boolean, default: false
  end
end
