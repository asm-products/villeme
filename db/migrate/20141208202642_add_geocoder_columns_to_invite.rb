class AddGeocoderColumnsToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :latitude, :string
    add_column :invites, :longitude, :string
    add_column :invites, :route, :string
    add_column :invites, :neighborhood_name, :string
    add_column :invites, :city_name, :string
    add_column :invites, :state_name, :string
    add_column :invites, :state_code, :string
    add_column :invites, :country_name, :string
    add_column :invites, :country_code, :string
    add_column :invites, :postal_code, :string
    add_column :invites, :street_number, :string
    add_column :invites, :full_address, :string
    add_column :invites, :formatted_address, :string
  end
end
