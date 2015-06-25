module Villeme
  module Policies
    class AccountComplete
      class << self

        require_relative '../../../../app/domain/policies/geocoder/entity_geocoded'

        def is_complete?(entity)
          if complete?(entity) && geocoded?(entity)
            true
          else
            false
          end
        end

        private

        def complete?(entity)
          entity.name && entity.username && entity.email && entity.personas.size > 0
        end

        def geocoded?(entity)
          Villeme::Policies::EntityGeocoded.is_geocoded?(entity)
        end


      end
    end
  end
end