module Villeme
  module Policies
    class AccountComplete
      class << self

        def is_complete?(entity)
          if complete?(entity)
            true
          else
            false
          end
        end

        private

        def complete?(entity)
          entity.name && entity.username && entity.email && entity.persona_id
        end

      end
    end
  end
end