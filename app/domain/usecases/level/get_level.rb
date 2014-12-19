module Villeme
  module UseCases
    class GetLevel
      class << self

        def next_level(intity)
          if entity.nivel.nil?
            false
          else
            next_level_nivel = intity.level.nivel + 1
            Level.find_by(nivel: next_level_nivel)
          end
        end

        def percentage_of_current_level(intity)
          unless intity.level.nil?
            ((intity.points - intity.level.points) * 100) / (intity.next_level.points - intity.level.points)
          end
        end

      end
    end
  end
end