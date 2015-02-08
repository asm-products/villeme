module Villeme
  module UseCases
    class CreateCityGeocoded

      def initialize(address)
        @address = address
      end


      def create_city
        @city = City.new(address: @address)
        @geocoder = geocoder_by_address

        if address_or_geocoder_is_nil? || city_exist?
          false
        else
          geocoderize_city
          save_city?
        end
      end


      private

      def address_or_geocoder_is_nil?
        @address.nil? || @geocoder.nil?
      end

      def city_exist?
        City.find_by(name: @geocoder.city)
      end

      def geocoder_by_address
        Geocoder.search(@address).first
      end

      def geocoderize_city
        if @geocoder
          @city.update_attributes(name: @geocoder.city,
                                  latitude: @geocoder.latitude,
                                  longitude: @geocoder.longitude,
                                  state_name: @geocoder.state,
                                  state_code: @geocoder.state_code,
                                  country_code: @geocoder.country_code,
                                  country_name: @geocoder.country
          )
        end
      end

      def save_city?
        if @city.save
          true
        else
          false
        end
      end

    end
  end
end