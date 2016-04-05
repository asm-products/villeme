class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :user, index: true
      t.string :email
      t.string :name
      t.integer :city
      t.integer :persona
      t.string :persona_suggest
      t.string :city_suggest
      t.string :key

      t.timestamps
    end
  end
end
