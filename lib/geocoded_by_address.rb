module GeocodedByAddress


  unless Rails.env.test?
    def geocoder_by_address
      nil
    end
  else
    def geocoder_by_address
      geocoded_by :address do |object, geocoder_results|
        geocoder = geocoder_results.first

        if geocoder
          object.latitude = geocoder.latitude
          object.longitude = geocoder.longitude
          object.route = geocoder.address_components_of_type(:route).first["short_name"]
          object.neighborhood_name = geocoder.address_components_of_type(:neighborhood).first["long_name"]
          object.city_name = geocoder.city
          object.state_name = geocoder.state
          object.state_code = geocoder.state_code
          object.country_code = geocoder.country_code
          object.country_name = geocoder.country
          object.postal_code = geocoder.postal_code
          object.street_number = geocoder.street_number
          object.full_address = geocoder.address
          object.formatted_address = "#{geocoder.address_components_of_type(:route).first["short_name"]}, #{geocoder.street_number} - #{geocoder.address_components_of_type(:neighborhood).first["long_name"]}"
        end
      end

      after_validation :geocode, unless: 'address.nil?'
    end
  end

end
