module Villeme
  module UseCases
    class GetLevel
      class << self

        def next_level(intity)
          next_level_nivel = intity.level.nivel + 1
          Level.find_by(nivel: next_level_nivel)
        end

      end
    end
  end
end