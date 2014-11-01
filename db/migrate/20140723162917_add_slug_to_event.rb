class AddSlugToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :slug, :string, unique: true
  	add_index :events, :slug
  end
end
