module Villeme
  module UseCases
    class GetCitySlug
      class << self

        def from_user(entity)
          user = entity

          if city_slug(user)
            city_slug(user)
          else
            nil
          end
        end


        private

        def city_slug(user)
          if user.city
            user.city.slug
          else
            false
          end
        end

      end
    end
  end
end