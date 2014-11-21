class Place < ActiveRecord::Base


	# validações
	

	# associações
	has_many :events, dependent: :destroy
	has_and_belongs_to_many :categories

	belongs_to :price


	# Geocoder
	geocoded_by :address do |place, geocoder_results|
		geocoder  = geocoder_results.first

		if geocoder
			place.latitude = geocoder.latitude
			place.longitude = geocoder.longitude
			place.street_number = geocoder.street_number
			place.postal_code = geocoder.postal_code
			place.neighborhood = geocoder.address_components_of_type(:neighborhood).first["long_name"]
			place.city = geocoder.city
			place.full_address = geocoder.address
			place.state = geocoder.state
			place.state_code = geocoder.state_code
			place.country_code = geocoder.country_code
			place.country = geocoder.country
			place.formatted_address = "#{geocoder.address_components_of_type(:route).first["short_name"]}, #{geocoder.street_number} - #{geocoder.address_components_of_type(:neighborhood).first["long_name"]}"
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
