class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.integer :neighborhood_id

      t.timestamps
    end
  end
end
