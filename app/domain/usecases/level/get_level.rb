module Villeme
  module UseCases
    class GetLevel
      class << self

        def next_level(entity)
          if entity.level.nil?
            false
          else
            next_level_nivel = entity.level.nivel + 1
            Level.find_by(nivel: next_level_nivel)
          end
        end

        def percentage_of_current_level(entity)
          if entity.level.nil? || entity.level.points.nil?
            0
          elsif entity.next_level
            ((entity.points - entity.level.points) * 100) / (entity.next_level.points - entity.level.points)
          else
            0
          end
        end

      end
    end
  end
end