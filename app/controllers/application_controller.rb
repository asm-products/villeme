# encoding: utf-8

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :current_user_home, if: :devise_controller?

 	before_filter :set_feedback_for_all

  layout :layout_devise_setting

  helper_method :strong_category

  # Gamificação
 	helper Gamification


 	


  protected


	# Cria o objeto para feedback em todo o app
	def set_feedback_for_all
		@feedback_app = Feedback.new
	end


  # carrega layout no devise
	def layout_devise_setting
	  if devise_controller? 
	    "centralize"
	  end
	end

	# verifica se o user esta logado
	def is_logged
		unless user_signed_in?
			redirect_to welcome_path, alert: "Ops! Você precisa estar logado para acessar isto."
		end
	end

	# verifica se o user e admin
	def is_admin
		unless user_signed_in?
			
			redirect_to welcome_path, alert: "Ops! Você não está logado."
		else

			unless current_user.admin?
				
				redirect_to root_path, alert: "Ops! Você não tem permissão para acessar isto."
			end
		end
	end


	# Verifica se a conta do user esta completa
	def is_complete
		if user_signed_in?
			if current_user.latitude.blank? and current_user.longitude.blank?
				redirect_to user_account_path(current_user.id), notice: "Agora só falta completar alguns dados e deu!"
			end
		end
	end

	def turn_complete(user)
		
	end


	# verifica se o user possui convite
	def is_invited
		if current_user.invited == false
			redirect_to welcome_path, notice: "#{current_user.name.split.first}, você precisa de um convite para acessar. Solicite abaixo!"
		else
			true
		end
	end







  def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :username, :email, :avatar, :latitude, :longitude, :password, :password_confirmation, :city_id, :neighborhood_id) }
	  devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :username, :email, :avatar, :latitude, :longitude, :password, :password_confirmation, :current_password, :city_id, :neighborhood_id) }
	end


	# latitude e longitude de onde o usuário mora
	def current_user_home
		if user_signed_in?

			# se o user tiver lat e long
			unless current_user.latitude.blank?
				gon.latitude = current_user.latitude
				gon.longitude = current_user.longitude
			else

				# se o user nao tiver lat e long mas tiver cidade
				unless current_user.city.nil?
					gon.latitude = current_user.city.latitude
					gon.longitude = current_user.city.longitude
				else

					# se o user nao tiver lat long nem cidade
					gon.latitude = 0
					gon.latitude = 0
			 	end 
			end
		end
	end


	# dia da semana que o evento esta acontecendo
	def dia_da_semana(variables)
		if Date.current.between?(variables[:date_start], variables[:date_finish]) 
			return ('<span class="label label-success today">Hoje</span>').html_safe
		elsif variables[:date_start] == Date.current.tomorrow
			return ('<span class="label label-success tomorrow">Amanhã</span>').html_safe
		else
			return I18n.localize variables[:date_start], format: "%A" 
		end			
	end	


	def verifica_hora(hora_db)
		unless hora_db.to_s == "2000-01-01 00:00:00 UTC"
			hora_db.strftime("%H:%M") << "h"
		else
			nil
		end
	end










	# Pega o endereço do evento
	def event_address(event)

		if event.place.nil?
			nil
		else
			place = "Em #{event.place.name}, "
		end


		# se o endereço do evento estiver branco
		if event.address.blank?

			# se o endereço do lugar <- evento não estiver branco
			unless event.place.address.blank?
				address = "#{event.place.address}, "
			else
				address = "Sem endereço"
			end

		# se o endereço do evento não estiver branco 	
		else
			address = "#{event.address}, "
		end

		# se o numero do evento estiver branco
		if event.number.blank?

			# se o numero do lugar <- evento não estiver branco
			unless event.place.number.blank?
				number = event.place.number
			else
				number = "Sem nº"
			end
		else
			number = event.number
		end		

		if event.neighborhood
			neighborhood = event.neighborhood.name
		elsif event.place.neighborhood
			neighborhood = event.place.neighborhood.name
		else
			neighborhood = event.neighborhood.address
		end		

		return place.to_s + address.to_s + number.to_s + " - " + neighborhood.to_s

	end

	helper_method :event_address




	def strong_category(event, type)

		# contador para retornar o mais forte se existir mais de uma categoria
		i = event.categories.count

		case type
		when 'slug'
			unless event.categories.empty?
				event.categories[0,2].each do |category|
					if i == 1
						return category.name
					elsif category.name != 'Lazer' 
						return category.name
					end
				end
			else
				return "lazer"
			end
		when 'item'
			unless event.categories.empty?
				event.categories[0,2].each do |category|
					if i == 1
						return "<a href='#{url_for(newsfeed_category_path(category))}'><span class='item #{category.name.downcase}'>#{category.name}</span></a>".html_safe
					elsif category.name != 'Lazer'
						return "<a href='#{url_for(newsfeed_category_path(category))}'><span class='item #{category.name.downcase}'>#{category.name}</span></a>".html_safe						
					end
				end
			else
				return nil
			end
		end

	end





	def cost(variable)
		if variable == 0 or variable.blank?
			return "Gratuito"
		else
			return variable.to_s.insert(-3, ",").insert(0, "R$")
		end
	end

	helper_method :cost




	# Verifica se o evento foi agendado pelo usuario
  def agended(event, user = current_user)

	    if user.agenda_events.include?(event)
	      return true
	    else
	      return false
	    end
    
  end

  helper_method :agended




  def clean_url(url)
  	if url.include?("https://")
  		url.gsub(/https:../) { |match|  }
  	elsif url.include?("http://")
  		url.gsub(/http:../) { |match|  }
		end
  end

  helper_method :clean_url



  def to_slug slug 
  	slug.to_s.downcase.strip.gsub(' ', '').gsub(/[^\w-]/, '')
  end

  helper_method :to_slug

  

  


end
