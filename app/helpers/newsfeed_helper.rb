# encoding: utf-8

module NewsfeedHelper

	def dia_da_semana(variables)
		if Date.today.between?(variables[:date_start], variables[:date_finish]) 
			return ('<span class="label label-success today">Hoje</span>').html_safe
		elsif variables[:date_start] == Date.today.tomorrow
			return ('<span class="label tomorrow">Amanhã</span>').html_safe
		else
			return ('<span class="label label-default">' + (I18n.localize variables[:date_start], format: "%A").to_s + '</span>').html_safe
		end			
	end

	


end
