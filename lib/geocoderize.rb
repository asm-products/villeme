module Geocoderize


  def geocoder_by_address
    geocoded_by :address do |object, geocoder_results|
      geocoder = geocoder_results.first

      if geocoder
        object.latitude = geocoder.latitude
        object.longitude = geocoder.longitude
        object.route = geocoder.address_components_of_type(:route).first["short_name"]
        object.street_number = geocoder.street_number
        object.postal_code = geocoder.postal_code
        object.neighborhood_name = geocoder.address_components_of_type(:neighborhood).first["long_name"]
        object.city_name = geocoder.city
        object.full_address = geocoder.address
        object.state_name = geocoder.state
        object.state_code = geocoder.state_code
        object.country_code = geocoder.country_code
        object.country_name = geocoder.country
        object.formatted_address = "#{geocoder.address_components_of_type(:route).first["short_name"]}, #{geocoder.street_number} - #{geocoder.address_components_of_type(:neighborhood).first["long_name"]}"
      end
    end

    after_validation :geocode, unless: 'address.nil?'
  end



  def copy_attributes_to(object)
    object.address = self.address
    object.number = self.number
    object.neighborhood_name = self.neighborhood_name
    object.city_name = self.city_name
    object.postal_code = self.postal_code
    object.state_name = self.state_name
    object.state_code = self.state_code
    object.country_name = self.country_name
    object.country_code = self.country_code
    object.full_address = self.full_address
    object.latitude = self.latitude
    object.longitude = self.longitude
  end


end
