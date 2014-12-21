module Villeme
  module UseCases
    class SetAccountCompleted
      class << self

        require_relative '../../../domain/policies/user/account_complete'

        def set_completed(entity)
          if account_completed?(entity)
            entity.update_attributes(account_complete: true)
            return true
          end

          false
        end


        private

        def account_completed?(entity)
          Villeme::Policies::AccountComplete.is_complete?(entity)
        end

      end
    end
  end
end