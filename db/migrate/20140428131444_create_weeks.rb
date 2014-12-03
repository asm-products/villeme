class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.string :name
      t.string :slug
      t.integer :binary

      t.timestamps
    end
  end
end
