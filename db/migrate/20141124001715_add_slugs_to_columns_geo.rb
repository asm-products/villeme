class AddSlugsToColumnsGeo < ActiveRecord::Migration
  def change
    add_column :countries, :slug, :string
    add_column :cities, :slug, :string
  end
end
