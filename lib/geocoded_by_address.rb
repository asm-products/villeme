module GeocodedByAddress


  if Rails.env.test?
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
          object.route = get_geocoder_for_route(geocoder) unless route_or_bus_station_not_empty?(geocoder)
          object.neighborhood_name = get_geocoder_for_neighborhood(geocoder) unless neighborhood_not_empty?(geocoder)
          object.city_name = geocoder.city
          object.state_name = geocoder.state
          object.state_code = geocoder.state_code
          object.country_code = geocoder.country_code
          object.country_name = geocoder.country
          object.postal_code = geocoder.postal_code
          object.street_number = geocoder.street_number
          object.full_address = geocoder.address
          object.formatted_address = "#{get_geocoder_for_route(geocoder)}, #{geocoder.street_number} - #{get_geocoder_for_neighborhood(geocoder)}" unless neighborhood_not_empty?(geocoder) && route_or_bus_station_not_empty?(geocoder)
        end
      end

      after_validation :geocode, unless: 'address.nil?'
    end
  end



  private

  def get_geocoder_for_neighborhood(geocoder)
    geocoder.address_components_of_type(:neighborhood).first["long_name"]
  end

  def neighborhood_not_empty?(geocoder)
    geocoder.address_components_of_type(:neighborhood).empty?
  end

  def get_geocoder_for_route(geocoder)
    route_component = geocoder.address_components_of_type(:route)
    bus_station_component = geocoder.address_components_of_type(:bus_station)

    if route_component.empty?
      bus_station_component.first["short_name"]
    else
      route_component.first["short_name"]
    end
  end

  def route_or_bus_station_not_empty?(geocoder)
    geocoder.address_components_of_type(:bus_station).empty? && geocoder.address_components_of_type(:route).empty?
  end

end
