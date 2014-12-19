module Villeme
  module UseCases
    class PointsLevel
      class << self

        def points_to_next_level(entity)
          if entity.next_level
            next_level_points = entity.next_level.points.to_i
            current_level_points = entity.points.to_i
            next_level_points - current_level_points
          else
            0
          end
        end

      end
    end
  end
end