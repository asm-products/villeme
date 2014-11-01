class Place < ActiveRecord::Base


	# validações
	

	# associações
	has_many :events, dependent: :destroy
	has_and_belongs_to_many :categories

	belongs_to :neighborhood
	belongs_to :price

	accepts_nested_attributes_for :neighborhood

	# Geocoder
	geocoded_by :address do |place_obj, results|
		if geo  = results.first
			place_obj.latitude = geo.latitude
			place_obj.longitude = geo.longitude
			place_obj.postal_code = geo.postal_code
			place_obj.neighborhood_name = geo.address_components_of_type(:neighborhood).first["long_name"]
			place_obj.city_name = geo.city
			place_obj.state = geo.state
			place_obj.state_code = geo.state_code
			place_obj.country = geo.country
			place_obj.country_code = geo.country_code
			place_obj.number = geo.street_number
			place_obj.full_address = geo.address
		end
	end

	after_validation :geocode



	def copy_attributes_to(event)
    event.address = self.address	
    event.number = self.number
    event.neighborhood_name = self.neighborhood_name
    event.city_name = self.city_name
    event.postal_code = self.postal_code
    event.state = self.state
    event.state_code = self.state_code
    event.country = self.country
    event.country_code = self.country_code
    event.full_address = self.full_address
    event.latitude = self.latitude
    event.longitude = self.longitude
	end


end
