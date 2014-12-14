module Villeme
  module User
    class GetEvents

      def initialize(user)
        @user = user
      end

      def events_from_neighborhood
        Event.where(neighborhood_name: @user.neighborhood_name)
      end

      def quantity_of_events_from_neighborhood
        if events_from_neighborhood.count > 0
          events_from_neighborhood.count
        else
          nil
        end
      end

      def neighborhood_has_events?
        if @user.quantity_of_events_from_neighborhood
          true
        else
          false
        end
      end

      def events_from_persona
        Event.where(persona_id: @user.persona_id)
      end

      def quantity_of_events_from_persona
        if events_from_persona.count > 0
          events_from_persona.count
        else
          nil
        end
      end

    end
  end
end