class CreateCategoriesEvents < ActiveRecord::Migration
  def change
    create_table :categories_events, id: false do |t|
      t.integer :category_id
      t.integer :event_id

      t.timestamps
    end
  end
end
