module Villeme
  module UseCases
    class GetPersonaName
      class << self

        def find_by_id(id)
          case id
          when 1 then I18n.t('personas.entrepreuner')
          when 2 then I18n.t('personas.gourmet')
          when 3 then I18n.t('personas.nerd')
          when 4 then I18n.t('personas.activist')
          when 5 then I18n.t('personas.actor')
          when 6 then I18n.t('personas.athlete')
          else 'Without persona'
          end
        end

      end
    end
  end
end