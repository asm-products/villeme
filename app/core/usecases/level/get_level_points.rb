module Villeme
  module Level
    class GetPoints
      class << self

        def points_to_next_level(entity)
          unless entity.level.nil?
            (entity.level.next.points).to_i - (entity.points).to_i
          end
        end

      end
    end
  end
end