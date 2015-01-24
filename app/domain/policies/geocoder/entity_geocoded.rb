module Villeme
  module Policies
    class EntityGeocoded
      class << self

        def is_geocoded?(entity)
          if geocoded?(entity)
            true
          else
            false
          end
        end

        private

        def geocoded?(entity)
          entity.latitude && entity.longitude && entity.address && entity.country_name
        end

      end
    end
  end
end