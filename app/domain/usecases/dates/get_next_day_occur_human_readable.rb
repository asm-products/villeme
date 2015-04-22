module Villeme
  module UseCases
    class Dates
      class << self

        def get_next_day_occur_human_readable(object, test_env=false)
          @object = object
          @test = test_env
          @object_week_days = get_binary_from_object
          @today = get_today
          @today_in_week = @today.wday
          @tomorrow_in_week = get_tomorrow_in_week

          if today_is_between_object_period_occur?
            if the_object_occur_in_this_week?
              return get_a_day_in_week_when_object_occur
            else
              return next_day_the_object_occur_in_month
            end
          else
            if @today < @object.date_start
              return next_day_the_object_occur_in_month
            elsif @today > @object.date_finish
              return nil
            end
          end
        end


        private

        def get_today
          if @test
            Date.parse('19-03-2015')
          else
            Date.current
          end
        end

        def get_tomorrow_in_week
          if @today_in_week < 6
            (@today + 1).strftime("%w").to_i
          else
            0
          end
        end

        def get_a_day_in_week_when_object_occur
          if the_object_occur_today?
            I18n.t('week.today')
          else
            if the_object_occur_tomorrow?
              I18n.t('week.tomorrow')
            else
              next_day_the_object_occur_in_week
            end
          end
        end

        def the_object_occur_tomorrow?
          if get_binary_from_object.include?(@tomorrow_in_week)
            true
          else
            false
          end
        end

        def next_day_the_object_occur_in_month
          period = (@object.date_start..@object.date_finish).to_a

          period.each do |day|
            if @object_week_days.include?(day.wday)
              return I18n.l(day, format: :short_month)
            else
              return I18n.l(@object.date_start, format: :short_month)
            end
          end
        rescue
          return I18n.l(@object.date_start, format: :short_month)
        end

        def next_day_the_object_occur_in_week
          @object_week_days.each do |day_binary|
            if day_binary > @today_in_week
              return get_day_from_week_from_binary(day_binary)
            end
          end

          return get_day_from_week_from_binary(@object_week_days.first)
        end

        def the_object_occur_today?
          if get_binary_from_object.include?(@today_in_week)
            true
          else
            false
          end
        end

        def days_left_to_start
          if @today == @object.date_finish
            0
          else
            period =  (@today..@object.date_finish).to_a
            next_day = period.find { |day| @object_week_days.include?(day.wday) }
            (next_day - @today).to_i
          end
        end

        def the_object_occur_in_this_week?
          if days_left_to_start < 7
            true
          else
            false
          end
        end

        def today_is_between_object_period_occur?
          if @today.between?(@object.date_start, @object.date_finish)
            true
          else
            false
          end
        end

        def get_binary_from_object
          array = []
          @object.weeks.each do |day|
            array << day.binary
          end

          return array
        end

        def get_day_from_week_from_binary(id)
          case id
            when 0 then I18n.t('week.sunday')
            when 1 then I18n.t('week.monday')
            when 2 then I18n.t('week.tuesday')
            when 3 then I18n.t('week.wednesday')
            when 4 then I18n.t('week.thursday')
            when 5 then I18n.t('week.friday')
            when 6 then I18n.t('week.saturday')
            else I18n.t('week.sunday')
          end
        end

      end
    end
  end
end