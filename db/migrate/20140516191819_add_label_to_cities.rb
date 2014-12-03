class AddLabelToCities < ActiveRecord::Migration
  def change
    add_column :cities, :label, :string
  end
end
