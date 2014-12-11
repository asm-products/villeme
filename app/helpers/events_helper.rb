# encoding: utf-8

module EventsHelper


	# Pega distância entre usuario e evento

	def set_distance(variables)

		# pega a distância entro o usuário e o evento
		if variables[:event_latitude].blank? and variables[:event_longitude].blank?
      place = Place.find(variables[:place_id])
      get_distance = Geocoder::Calculations.distance_between([variables[:user_latitude], variables[:user_longitude]], [place.latitude, place.longitude], {units: :km}).round(3)
    else
      get_distance = Geocoder::Calculations.distance_between([variables[:user_latitude], variables[:user_longitude]], [variables[:event_latitude], variables[:event_longitude]], {units: :km}).round(3)
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
		when :minutes
			case
			when distance >= 4.0 # bus
				margem = (distance / 100) * 30
				algorithm = (distance / 35 * 60) + (margem) + (10).round(3)
				resposta[0] = algorithm.round.to_s << "min. indo de ônibus"
				resposta[1] = "de ônibus"
				resposta[2] = "bus"
				return resposta
			when distance < 4.0 # walk
				algorithm = (distance / 4.5 * 60).round(3)
				resposta[0] = algorithm.round.to_s << "min."
				resposta[1] = "à pé"
				resposta[2] = "walk"
				return resposta
      else
          nil
      end

    else
      nil
    end

	end





	def absolute_image_url(image_name, image_style = :original)
  	"#{request.protocol}#{request.host_with_port}#{attachment_name.url(attachment_style)}"
	end




	def address_formatted(event)
		if event.place.nil?
			event.address
		else
      event.place.name
		end
	end




	def formata_hora(hora)
		hora.strftime("%H:%M") << "h"
	end





	def get_hours(event)


		valid_hours = Hash.new


    # 1 horario
    if hour_valid?(event.hour_start_first)
			valid_hours[:first] = Hash.new
			valid_hours[:first][:start] = formata_hora(event.hour_start_first)
    end



		if hour_valid? event.hour_finish_first
			valid_hours[:first][:finish] = formata_hora(event.hour_finish_first)
		end

		# 2 horario
		if hour_valid? event.hour_start_second
			valid_hours[:second] = Hash.new
			valid_hours[:second][:start] = formata_hora(event.hour_start_second)
		end

		if hour_valid? event.hour_finish_second
			valid_hours[:second][:finish] = formata_hora(event.hour_finish_second)
		end


		# 3 horario
		if hour_valid? event.hour_start_third
			valid_hours[:third] = Hash.new
			valid_hours[:third][:start] = formata_hora(event.hour_start_third)
		end

		if hour_valid? event.hour_finish_third
			valid_hours[:third][:finish] = formata_hora(event.hour_finish_third)
		end


		# 4 horario
		if hour_valid? event.hour_start_fourth
			valid_hours[:fourth] = Hash.new
			valid_hours[:fourth][:start] = formata_hora(event.hour_start_fourth)
		end

		if hour_valid? event.hour_finish_fourth
			valid_hours[:fourth][:finish] = formata_hora(event.hour_finish_fourth)
		end


		# 5 horario
		if hour_valid? event.hour_start_fifth
			valid_hours[:fifth] = Hash.new
			valid_hours[:fifth][:start] = formata_hora(event.hour_start_fifth)
		end

		if hour_valid? event.hour_finish_fifth
			valid_hours[:fifth][:finish] = formata_hora(event.hour_finish_fifth)
		end


		# 6 horario
		if hour_valid? event.hour_start_sixth
			valid_hours[:sixth] = Hash.new
			valid_hours[:sixth][:start] = formata_hora(event.hour_start_sixth)
		end

		if hour_valid? event.hour_finish_sixth
			valid_hours[:sixth][:finish] = formata_hora(event.hour_finish_sixth)
		end


		array_retorno = []
		count = 1

		valid_hours.each do |key, hash|

			start_hour = hash[:start]

			# exibe a data final somente se existir
      if hash[:finish].blank?
        array_retorno << "#{count}º - #{start_hour}"
      else
        array_retorno << "#{count}º - #{start_hour} até #{hash[:finish]}"
      end

			count += 1
		end

    return array_retorno


	end

  def hour_valid?(hour)
    case hour
      when nil
        false
      when "2000-01-01 00:00:00 UTC"
        false
      else
        true
    end
  end

end
