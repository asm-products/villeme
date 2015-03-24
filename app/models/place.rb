class Place < ActiveRecord::Base

	# Geocoder
	extend  GeocodedByAddress
	include GeocodedActions
	geocoder_by_address

	# image in the POST method
	has_attached_file :cover

	# Gem Paperclip
	has_attached_file :cover,
										styles: {large: "280x280>", normal: "180x180>"},
										default_url: "/images/:style/missing.png"

	# associates
	has_many :events, dependent: :destroy
	has_and_belongs_to_many :categories
	belongs_to :price

end
