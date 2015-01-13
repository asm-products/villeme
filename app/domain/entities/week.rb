module Villeme
  module Entities
    class Week

      def initialize(id)
        @id = id
      end

      def get_day_of_week
        case @id
        when 1 then I18n.t('week.sunday')
        when 2 then I18n.t('week.monday')
        when 3 then I18n.t('week.tuesday')
        when 4 then I18n.t('week.wednesday')
        when 5 then I18n.t('week.thursday')
        when 6 then I18n.t('week.friday')
        when 7 then I18n.t('week.saturday')
        end
      end

    end
  end
end