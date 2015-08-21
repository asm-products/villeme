class AddTypeToItem < ActiveRecord::Migration
  def change
    add_column :items, :type, :string
  end
end
