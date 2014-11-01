class CreateNotifies < ActiveRecord::Migration
  def change
    create_table :notifies do |t|
      t.references :user, index: true
      t.datetime :bell_view
      t.datetime :newsfeed_view
      t.datetime :persona_view
      t.datetime :neighborhood_view
      t.datetime :agenda_view
      t.datetime :category_view

      t.timestamps
    end
  end
end
