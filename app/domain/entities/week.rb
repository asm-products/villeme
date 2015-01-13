module Villeme
  module Entities
    class Week

      attr_accessor :id, :name

      def initialize(id=1)
        @id = id
      end

    end
  end
end