class Place < ActiveRecord::Base

	extend Geocoderize

	# associações
	has_many :events, dependent: :destroy
	has_and_belongs_to_many :categories

	belongs_to :price


	# Geocoder
	geocoded_by_address







end
