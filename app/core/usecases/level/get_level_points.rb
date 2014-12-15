module Villeme
  module UseCases
    class GetPoints
      class << self

        def points_to_next_level(entity)
            next_level_points = entity.next_level.points.to_i
            current_level_points = entity.points.to_i
            next_level_points - current_level_points
        end

      end
    end
  end
end