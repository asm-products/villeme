module Villeme
  module UseCases
    class IconLevel
      class << self

        def get_icon(entity)
          entity.level.icon.url(:original) unless entity.level.nil?
        end

      end
    end
  end
end