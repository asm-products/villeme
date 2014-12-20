module Villeme
  module UseCases
    class CreateCityGeocoded

      def initialize(address)
        @address = address
      end


      def create_city
        city = City.new(address: @address)
        geocoder = geocoder_by_address

        if city_exist?(geocoder)
          false
        else
          geocoderize_city(city, geocoder)
          save_city?(city)
        end
      end


      private

      def city_exist?(geocoder)
        City.find_by(name: geocoder.city)
      end

      def geocoder_by_address
        Geocoder.search(@address).first
      end

      def geocoderize_city(city, geocoder)
        if geocoder
          city.update_attributes(name: geocoder.city,
          latitude: geocoder.latitude,
          longitude: geocoder.longitude,
          state_name: geocoder.state,
          state_code: geocoder.state_code,
          country_code: geocoder.country_code,
          country_name: geocoder.country
          )
        end
      end

      def save_city?(object)
        if object.save
          true
        else
          false
        end
      end

    end
  end
end