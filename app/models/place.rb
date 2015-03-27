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
	belongs_to :user
	belongs_to :price

	# validates
	validates :name, presence: true, uniqueness: true, length: 0..140
	validates :description, allow_blank: true, length: 10..5000
	validates :phone, allow_blank: true, length: 0..50
	validates :site, allow_blank: true, length: 0..250



	def get_address
		if address.blank?
			self.full_address
		else
			self.address
		end
	end

end
