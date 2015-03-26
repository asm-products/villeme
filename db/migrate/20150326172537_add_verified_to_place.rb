class AddVerifiedToPlace < ActiveRecord::Migration
  def change
    add_column :places, :verified, :boolean, default: false
  end
end
