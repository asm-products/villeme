class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :code

      t.timestamps
    end
  end
end
