class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.text :description
      t.integer :city_id

      t.timestamps
    end
  end
end
