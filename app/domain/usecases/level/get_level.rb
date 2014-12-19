module Villeme
  module UseCases
    class GetLevel
      class << self

        def next_level(entity)
          if entity.nivel.nil?
            false
          else
            next_level_nivel = entity.level.nivel + 1
            Level.find_by(nivel: next_level_nivel)
          end
        end

        def percentage_of_current_level(entity)
          if entity.level.nil?
            0
          else
            ((entity.points - entity.level.points) * 100) / (entity.next_level.points - entity.level.points)
          end
        end

      end
    end
  end
end