class AddSlugToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :slug, :string
    add_index :neighborhoods, :slug, unique: true
  end
end
