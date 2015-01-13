module Villeme
  module Entities
    class Week

      attr_accessor :id

      def initialize(id = 1)
        @id = id
      end

      def self.get_day_by_id(id)
        case id
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