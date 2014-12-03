class AddNumberToPlace < ActiveRecord::Migration
  def change
    add_column :places, :number, :integer
  end
end
