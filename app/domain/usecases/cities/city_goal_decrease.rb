module Villeme
  module UseCases
    class CityGoalDecrease

      def initialize(city)
        @city = city
      end

      def decrease
        @city.goal -= 1
      end

    end
  end
end