class Place < ActiveRecord::Base

	# Geocoder
	extend  GeocodedByAddress
	include GeocodedActions

	geocoder_by_address

	# associates
	has_many :events, dependent: :destroy
	has_and_belongs_to_many :categories
	belongs_to :price

end
