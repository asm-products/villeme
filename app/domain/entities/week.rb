module Villeme
  module Entities
    class Week

      def initialize(id)
        @id = id
      end

      def get_day_of_week
        case @id
        when 1 then 'Domingo'
        when 2 then 'Segunda'
        when 3 then 'Terça'
        when 4 then 'Quarta'
        when 5 then 'Quinta'
        when 6 then 'Sexta'
        when 7 then 'Sábado'
        end
      end

    end
  end
end