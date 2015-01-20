module Villeme
  module UseCases
    class CityGoalDecrease

      def initialize(city)
        @city = city
      end

      def decrease
        @city.update_attributes(goal: @city.goal - 1)
        @city.goal
      end

    end
  end
end