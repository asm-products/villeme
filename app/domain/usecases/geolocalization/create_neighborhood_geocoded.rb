module Villeme
  module UseCases
    class CreateNeighborhoodGeocoded

      def initialize(address)
        @address = address
      end


      def create_neighborhood
        neighborhood = Neighborhood.new(address: @address)
        geocoder = geocoder_by_address

        if neighborhood_exist?(geocoder)
          false
        else
          geocoderize_neighborhood(neighborhood, geocoder)
          save_neighborhood?(neighborhood)
        end
      end


      private

      def neighborhood_exist?(geocoder)
        Neighborhood.find_by(name: geocoder.neighborhood)
      end

      def geocoder_by_address
        Geocoder.search(@address).first
      end

      def geocoderize_neighborhood(neighborhood, geocoder)
        if geocoder
          neighborhood.update_attributes(name: geocoder.address_components_of_type(:neighborhood).first["long_name"],
                                 latitude: geocoder.latitude,
                                 longitude: geocoder.longitude,
                                 city_name: geocoder.city,
                                 state_name: geocoder.state,
                                 state_code: geocoder.state_code,
                                 country_code: geocoder.country_code,
                                 country_name: geocoder.country
          )
        end
      end

      def save_neighborhood?(object)
        if object.save
          true
        else
          false
        end
      end

    end
  end
end