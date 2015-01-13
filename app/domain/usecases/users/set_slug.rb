module Villeme
  module UseCases
    class SetSlug
      class << self

        def to_slug(text)
          text.parameterize
        end

      end
    end
  end
end