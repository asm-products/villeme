class AddPhoneAndSiteToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :phone, :string
    add_column :places, :site, :string
  end
end
