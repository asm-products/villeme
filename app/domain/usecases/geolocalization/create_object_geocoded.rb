module Villeme
  module UseCases
    class CreateObjectGeocoded

      require_relative '../../../domain/usecases/geolocalization/create_city_geocoded'

      def initialize(address)
        @address = address
      end

      def create_objects
        create_city
      end

      private

      def create_city
        Villeme::UseCases::CreateCityGeocoded.new(@address).create_city
      end



    end
  end
end