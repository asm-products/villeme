module Villeme
  module UseCases
    class CreateObjectGeocoded

      require_relative '../../../domain/usecases/geolocalization/create_city_geocoded'
      require_relative '../../../domain/usecases/geolocalization/create_neighborhood_geocoded'

      def initialize(address)
        @address = address
      end

      def create_objects
        if create_city_or_neighborhood
          true
        else
          false
        end
      end


      private

      def create_city_or_neighborhood
        create_city and create_neighborhood
      end

      def create_city
        Villeme::UseCases::CreateCityGeocoded.new(@address).create_city
      end

      def create_neighborhood
        Villeme::UseCases::CreateNeighborhoodGeocoded.new(@address).create_neighborhood
      end


    end
  end
end