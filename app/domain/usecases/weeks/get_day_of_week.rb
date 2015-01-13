module Villeme
  module UseCases
    class GetDayOfWeek
      class << self

        def get_day_by_id(id)
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
end