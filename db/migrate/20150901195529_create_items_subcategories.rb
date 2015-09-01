class CreateItemsSubcategories < ActiveRecord::Migration
  def change
    create_table :items_subcategories, id: false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :subcategory, index: true
    end
  end
end
