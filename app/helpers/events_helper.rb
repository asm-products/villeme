# encoding: utf-8

module EventsHelper


	# Pega distância entre usuario e evento

	def set_distance(variables)

		# pega a distância entro o usuário e o evento
		unless variables[:event_latitude].blank? and variables[:event_longitude].blank? 
			get_distance = Geocoder::Calculations.distance_between([variables[:user_latitude], variables[:user_longitude]],[variables[:event_latitude],variables[:event_longitude]], {units: :km}).round(3)
		else
			place = Place.find(variables[:place_id])
			get_distance = Geocoder::Calculations.distance_between([variables[:user_latitude], variables[:user_longitude]],[place.latitude,place.longitude], {units: :km}).round(3)			
		end

		# cria uma margem de erro de 20% positivo
		margem = get_distance.round(3) / 100 * 33

		# adiciona a margem a distância
		distance = (get_distance + margem).round(3)

		# array de resposta
		resposta = Array.new

		case variables[:type]
		when :km
			return distance.to_s << "km"
		when :transport
			case 
			when distance >= 4.0 # bus
				margem = (distance / 100) * 30
				algorithm = (distance / 35 * 60) + (margem) + (10).round(3)
				resposta[0] = algorithm.round.to_s << "min. indo de ônibus"
				resposta[1] = "de ônibus"
				resposta[2] = "bus"
				return resposta				
			
			# when distance >= 4.0 # car
			# 	algorithm = (distance / 40 * 60).round(3)
			# 	resposta[0] = algorithm.round.to_s << "min."
			# 	resposta[1] = "de carro"
			# 	resposta[2] = "car"
			# 	return resposta
			# 	# return ((algorithm / 60).round.to_s << "h") + (((algorithm / 60).round(3).to_s.last(3).to_i / 100 * 60).to_s.slice(0..1) + "min")
			
			# when distance >= 4.0 # bike
			# 	margem = (distance / 100) * 20
			# 	algorithm = (distance / 20 * 60) + (margem).round(3)
			# 	resposta[0] = algorithm.round.to_s << "min."
			# 	resposta[1] = "de bicicleta"
			# 	resposta[2] = "bike"
			# 	return resposta				
			
			when distance < 4.0 # walk
				algorithm = (distance / 4.5 * 60).round(3)
				resposta[0] = algorithm.round.to_s << "min."
				resposta[1] = "à pé"
				resposta[2] = "walk" 
				return resposta
			end
		end

	end





	def absolute_image_url(image_name, image_style = :original)
  	"#{request.protocol}#{request.host_with_port}#{attachment_name.url(attachment_style)}"
	end




	def address_formatted(event)
		if event.place.nil?
			event.address
		else
			return event.place.name
		end
	end




	# dia da semana que o evento esta acontecendo
	def dia_da_semana(variables)
		if Date.today.between?(variables[:date_start], variables[:date_finish]) 
			return ('<span class="label label-success today">Hoje</span>').html_safe
		elsif variables[:date_start] == Date.today.tomorrow
			return ('<span class="label label-success tomorrow">Amanhã</span>').html_safe
		else
			return I18n.localize variables[:date_start], format: "%A" 
		end			
	end	




	def formata_hora(hora)
		hora.strftime("%H:%M") << "h"
	end





	def get_hours(event)

		# array que armazenara os horarios validos
		valid_hours = Hash.new 

		# verifica os horarios

		# 1 horario
		if event.hour_start_first != "2000-01-01 00:00:00 UTC"
			valid_hours[:first] = Hash.new 
			valid_hours[:first][:start] = formata_hora(event.hour_start_first)
		end

		if event.hour_finish_first != "2000-01-01 00:00:00 UTC"
			valid_hours[:first][:finish] = formata_hora(event.hour_finish_first)
		end

		# 2 horario
		if event.hour_start_second != "2000-01-01 00:00:00 UTC"
			valid_hours[:second] = Hash.new 
			valid_hours[:second][:start] = formata_hora(event.hour_start_second)
		end

		if event.hour_finish_second != "2000-01-01 00:00:00 UTC"
			valid_hours[:second][:finish] = formata_hora(event.hour_finish_second)	
		end		
				

		# 3 horario
		if event.hour_start_third != "2000-01-01 00:00:00 UTC"
			valid_hours[:third] = Hash.new 
			valid_hours[:third][:start] = formata_hora(event.hour_start_third)
		end

		if event.hour_finish_third != "2000-01-01 00:00:00 UTC"
			valid_hours[:third][:finish] = formata_hora(event.hour_finish_third)
		end			
			

		# 4 horario
		if event.hour_start_fourth != "2000-01-01 00:00:00 UTC"
			valid_hours[:fourth] = Hash.new 
			valid_hours[:fourth][:start] = formata_hora(event.hour_start_fourth)
		end

		if event.hour_finish_fourth != "2000-01-01 00:00:00 UTC"
			valid_hours[:fourth][:finish] = formata_hora(event.hour_finish_fourth)
		end


		# 5 horario
		if event.hour_start_fifth != "2000-01-01 00:00:00 UTC"
			valid_hours[:fifth] = Hash.new 
			valid_hours[:fifth][:start] = formata_hora(event.hour_start_fifth)
		end

		if event.hour_finish_fifth != "2000-01-01 00:00:00 UTC"
			valid_hours[:fifth][:finish] = formata_hora(event.hour_finish_fifth)
		end


		# 6 horario
		if event.hour_start_sixth != "2000-01-01 00:00:00 UTC"
			valid_hours[:sixth] = Hash.new 
			valid_hours[:sixth][:start] = formata_hora(event.hour_start_sixth)
		end

		if event.hour_finish_sixth != "2000-01-01 00:00:00 UTC"
			valid_hours[:sixth][:finish] = formata_hora(event.hour_finish_sixth)
		end			


		array_retorno = []
		count = 1

		valid_hours.each do |key, hash|

			start_hour = hash[:start]

			# exibe a data final somente se existir
			finish_hour = " até #{hash[:finish]}" unless hash[:finish].blank?

			array_retorno << "#{count}º - #{start_hour}#{finish_hour}"
			count+= 1
		end

		return array_retorno

		# o valor de 'valid_hours'
		# {:first=>{:start=>"19:00h", :finish=>"05:04h"}, :second=>{:start=>"05:04h", :finish=>"03:05h"}, :third=>{:start=>"04:03h", :finish=>"04:04h"}}
		
	end	

end
