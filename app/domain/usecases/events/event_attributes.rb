module Villeme
  module UseCases
    class EventAttributes
      class << self

        def name_with_limit(entity)
          name = entity.name

          if name.length > 45
            "#{name[0..45]}..."
          else
            name
          end
        end


        def description_with_limit(entity)

          return nil if entity.description.nil?

          name = entity.name
          description = ActionController::Base.helpers.strip_tags(entity.description)
          if name.length > 25
            "#{description[0..70]}..."
          else
            "#{description[0..100]}..."
          end
        end


        def price(entity)
          response = Hash.new(value: nil, css_attributes: nil)
          number_to_currency = ActionController::Base.helpers.number_to_currency(entity.cost, locale: I18n.locale)

          if entity.cost == 0 or entity.cost.blank?
            response[:value] = I18n.t('event.free')
            response[:css_attributes] = 'is-free'
          elsif entity.cost < 12
            response[:value] = number_to_currency
            response[:css_attributes] = 'is-highlight'
          else
            response[:value] = number_to_currency
          end

          response
        end



        def period_that_occurs(entity)
          "#{entity.date_start.strftime("%d/%m")} - #{entity.date_finish.strftime("%d/%m")}"
        end


        def get_start_hour(entity)
          if entity.allday?
            'AM-PM'
          else
            hour = entity.hour_start_first.strftime('%H:%M')
            hour.include?(':00') ? hour.chomp(':00') << 'h' : hour << 'h'
          end
        end

      end
    end
  end
end