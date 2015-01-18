# encoding: utf-8

class ApplicationController < ActionController::Base

  require_relative '../../app/domain/policies/user/account_complete'
  require_relative '../../app/domain/usecases/users/set_locale'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :configure_permitted_parameters, if: :devise_controller?
  # before_filter :current_user_home, if: :devise_controller?
  before_filter :set_locale
  before_filter :get_user_city_slug
 	before_filter :set_feedback_for_all
  layout :layout_devise_setting

  helper_method :strong_category

  # Gamificação
 	helper Gamification


  protected

  def set_locale
    if current_user || params[:locale]
      Villeme::UseCases::SetLocale.new(current_user).set_locale(params)
    else
      Villeme::UseCases::SetLocale.new(nil).set_locale_from_ip(get_user_ip)
    end
  end


  def get_user_ip
    if Rails.env.test?
      '177.18.147.47'
    elsif request.remote_ip == '127.0.0.1'
      '177.18.147.47'
    else
      request.remote_ip
    end
  end


  def get_user_city_slug
    if current_user
      @user_city_slug = current_user.city_slug
    else
      @user_city_slug = 'newsfeed'
    end
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end


  def set_feedback_for_all
		@feedback_app = Feedback.new
	end



	def layout_devise_setting
	  if devise_controller? 
	    "centralize"
	  end
	end

	
	def is_logged
		unless user_signed_in?
			redirect_to welcome_path, alert: "Ops! Você precisa estar logado para acessar isto."
		end
	end

	
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
		unless user_signed_in? && Villeme::Policies::AccountComplete.is_complete?(current_user)
			redirect_to user_account_path(current_user), notice: "Agora só falta completar sua conta"
		end
	end

	def turn_complete(user)
		
	end


	
	def is_invited
    if current_user.invited
      true
    else
      redirect_to welcome_path, notice: "#{current_user.name.split.first}, você precisa de um convite para acessar. Solicite abaixo!"
    end
	end







  def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,
                                                            :username,
                                                            :email,
                                                            :avatar,
                                                            :address,
                                                            :password,
                                                            :password_confirmation,
                                                            :city_id,
                                                            :neighborhood_id)}

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name,
                                                                   :username,
                                                                   :email,
                                                                   :avatar,
                                                                   :address,
                                                                   :password,
                                                                   :password_confirmation,
                                                                   :current_password,
                                                                   :city_id,
                                                                   :neighborhood_id)}
	end


	# latitude e longitude de onde o usuário mora
	def current_user_home
		if user_signed_in?
      if current_user.latitude.blank?
        set_currentuser_lat_long
      else
        gon.latitude = current_user.latitude
        gon.longitude = current_user.longitude
      end
		end
  end

  helper_method :current_user_home

  def set_currentuser_lat_long
    if current_user.city.nil?
      gon.latitude = 0
      gon.latitude = 0
    else
      gon.latitude = current_user.city.latitude
      gon.longitude = current_user.city.longitude
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


  helper_method :dia_da_semana


	def verifica_hora(hora_db)
    if hora_db.to_s == "2000-01-01 00:00:00 UTC"
      nil
    else
      hora_db.strftime("%H:%M") << "h"
    end
	end











	def strong_category(event, type)

		# contador para retornar o mais forte se existir mais de uma categoria
		i = event.categories.count

		case type
		when 'slug'
      return categories_slug(event, i)
		when 'item'
      return categories_item(event, i)
		end

	end

  def categories_item(event, i)
    if event.categories.empty?
      return nil
    else
      event.categories[0, 2].each do |category|
        if i == 1
          return "<a href='#{url_for(newsfeed_category_path(category))}'><span class='item #{category.name.downcase}'>#{category.name}</span></a>".html_safe
        elsif category.name != 'Lazer'
          return "<a href='#{url_for(newsfeed_category_path(category))}'><span class='item #{category.name.downcase}'>#{category.name}</span></a>".html_safe
        end
      end
    end
  end

  def categories_slug(event, i)
    if event.categories.empty?
      return "lazer"
    else
      event.categories[0, 2].each do |category|
        if i == 1
          return category.name
        elsif category.name != 'Lazer'
          return category.name
        end
      end
    end
  end





  def cost(variable)
		if variable == 0 or variable.blank?
			return "Gratuito"
		else
			return variable
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
