module Villeme
  module Events
    class GetEvents
      class << self

        def from_neighborhood(entity)
          Event.where(neighborhood_name: entity.neighborhood_name)
        end

        def quantity_from_neighborhood(entity)
          if from_neighborhood(entity).count > 0
            from_neighborhood(entity).count
          else
            nil
          end
        end

        def neighborhood_has_events?(entity)
          if quantity_from_neighborhood(entity)
            true
          else
            false
          end
        end

        def from_persona(entity)
          Event.where(persona_id: entity.persona_id)
        end

        def quantity_of_events_from_persona(entity)
          if from_persona(entity).count > 0
            from_persona(entity).count
          else
            nil
          end
        end

      end
    end
  end
end