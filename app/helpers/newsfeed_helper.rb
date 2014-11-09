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

    if user.events_from_my_neighborhood_count > 0
      count = "#{t('dictionary.have_events', neighborhood_count: user.events_from_my_neighborhood.count)}"
    else
      count = "#{t('dictionary.no_have_events')}"
    end

    "#{t('dictionary.show_events_number_in_neighborhood', count: count)}"
  end


end
