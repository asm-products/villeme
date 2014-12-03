class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :country
      t.string :country_code
      t.string :code

      t.timestamps
    end
  end
end
