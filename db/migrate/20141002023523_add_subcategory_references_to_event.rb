class AddSubcategoryReferencesToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :subcategory, index: true
  end
end
