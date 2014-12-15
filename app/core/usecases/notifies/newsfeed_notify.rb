module Villeme
  module UseCases
    class NewsfeedNotify
      class << self

        def get_notifies(entity)
          if entity.has_notify
            if entity.notify.newsfeed_view.blank?
              notify_date = DateTime.current - 300
            else
              notify_date = entity.notify.newsfeed_view
            end
            Event.where("created_at BETWEEN ? AND ?", notify_date, DateTime.current)
          end
        end

      end
    end
  end
end