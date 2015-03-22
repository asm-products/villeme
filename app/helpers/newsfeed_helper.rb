# encoding: utf-8

module NewsfeedHelper

	def dia_da_semana(variables)
		if Date.today.between?(variables[:date_start], variables[:date_finish])
      ('<span class="label label-success today">Hoje</span>').html_safe
		elsif variables[:date_start] == Date.today.tomorrow
		  ('<span class="label tomorrow">Amanhã</span>').html_safe
		else
      ('<span class="label label-default">' + (I18n.localize variables[:date_start], format: "%A").to_s + '</span>').html_safe
		end			
	end


  def show_events_number_in_neighborhood_of(user)

    if user.my_neighborhood_has_events?
      count = "#{t('dictionary.have_events', neighborhood_count: user.quantity_of_events_from_neighborhood)}"
    else
      count = "#{t('dictionary.no_have_events')}"
    end

    "#{t('dictionary.show_events_number_in_neighborhood', count: count)}"
  end

  def cache_key_for_events
    count          = Event.count
    event_max_updated_at = Event.maximum(:updated_at).try(:utc).try(:to_s, :number)
    agenda_max_updated_at = current_user.agendas.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "events/all-#{count}-#{event_max_updated_at}-#{agenda_max_updated_at}"
  end

end
