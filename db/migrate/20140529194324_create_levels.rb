class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :nivel
      t.string :url
      t.integer :points

      t.timestamps
    end
  end
end
