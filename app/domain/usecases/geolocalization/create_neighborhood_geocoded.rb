module Villeme
  module UseCases
    class CreateNeighborhoodGeocoded

      def initialize(address)
        @address = address
      end


      def create_neighborhood
        @neighborhood = Neighborhood.new(address: @address)
        @geocoder = geocoder_by_address

        if neighborhood_or_geocoder_is_nil? or neighborhood_exist?
          false
        else
          geocoderize_neighborhood
          save_neighborhood?
        end
      end


      private

      def neighborhood_or_geocoder_is_nil?
        @neighborhood.nil? || @geocoder.nil?
      end

      def neighborhood_exist?
        Neighborhood.find_by(name: @geocoder.neighborhood)
      end

      def geocoder_by_address
        Geocoder.search(@address).first
      end

      def geocoderize_neighborhood
        if @geocoder
          @neighborhood.update_attributes(name: @geocoder.address_components_of_type(:neighborhood).first["long_name"],
                                         latitude: @geocoder.latitude,
                                         longitude: @geocoder.longitude,
                                         city_name: @geocoder.city,
                                         state_name: @geocoder.state,
                                         state_code: @geocoder.state_code,
                                         country_code: @geocoder.country_code,
                                         country_name: @geocoder.country
          )
        end
      end

      def save_neighborhood?
        if @neighborhood.save
          true
        else
          false
        end
      end

    end
  end
end