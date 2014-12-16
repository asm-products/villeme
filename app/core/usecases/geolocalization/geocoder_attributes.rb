module Villeme
  module UseCases
    class GeocoderAttributes
      class << self


        def relative_latitude(entity)
          if entity.latitude.blank?
            entity.place.latitude
          else
            entity.latitude
          end
        end

        def relative_longitude(entity)
          if entity.longitude.blank?
            entity.place.longitude
          else
            entity.longitude
          end
        end


      end
    end
  end
end