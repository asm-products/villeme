module Villeme
  module UseCases
    class GeocodeEvent

      require_relative '../../policies/geocoder/entity_geocoded'

      def initialize(entity)
        @event = entity
      end

      def geocoded_by_address(address)
        @address = address

        if Rails.env.test?
          if @address.nil?
            return FactoryGirl.build(:event, address: nil)
          else
            return FactoryGirl.build(:event)
          end
        end

        geocoderize_event(geocoding_by_address)

        if event_is_geocoded?
          @event
        end
      end



      private

      def event_is_geocoded?
        Villeme::Policies::EntityGeocoded.is_geocoded?(@event)
      end

      def geocoding_by_address
        Geocoder.search(@address).first
      end

      def geocoderize_event(geocoder)
        if geocoder
          @event.assign_attributes({latitude: geocoder.latitude,
                                  longitude: geocoder.longitude,
                                  city_name: geocoder.city,
                                  neighborhood_name: get_geocoder_for_neighborhood(geocoder),
                                  state_name: geocoder.state,
                                  state_code: geocoder.state_code,
                                  country_code: geocoder.country_code,
                                  country_name: geocoder.country,
                                  route: get_geocoder_for_route(geocoder),
                                  postal_code: geocoder.postal_code,
                                  street_number: geocoder.street_number,
                                  full_address: geocoder.address,
                                  formatted_address: get_formatted_address(geocoder)
          })
        end
      end

      def get_geocoder_for_neighborhood(geocoder)
        if neighborhood_empty?(geocoder)
          nil
        else
          geocoder.address_components_of_type(:neighborhood).first["long_name"]
        end
      end

      def get_geocoder_for_route(geocoder)
        if route_or_bus_station_empty?(geocoder)
          nil
        else
          route_component = geocoder.address_components_of_type(:route)
          bus_station_component = geocoder.address_components_of_type(:bus_station)

          if route_component.empty?
            bus_station_component.first["short_name"]
          else
            route_component.first["short_name"]
          end
        end
      end

      def get_formatted_address(geocoder)
        if neighborhood_empty?(geocoder) && route_or_bus_station_empty?(geocoder)
          nil
        else
          "#{get_geocoder_for_route(geocoder)}, #{geocoder.street_number} - #{get_geocoder_for_neighborhood(geocoder)}"
        end
      end

      def neighborhood_empty?(geocoder)
        geocoder.address_components_of_type(:neighborhood).empty?
      end

      def route_or_bus_station_empty?(geocoder)
        geocoder.address_components_of_type(:bus_station).empty? && geocoder.address_components_of_type(:route).empty?
      end


    end
  end
end