class NewsfeedController < ApplicationController
  
  # verifica se o user esta logado
  before_action :is_logged

  # verifica se a conta esta completa
  before_action :is_invited

  # verifica se a conta esta completa
  before_action :is_complete

  include Gmaps



	# Layout newsfeed
	layout "three-columns"


  def index

    if params[:category]
      @category = Category.friendly.find params[:category]
      @events = @category.events.upcoming

    elsif params[:city] && params[:neighborhood]
      @city = City.find_by(slug: params[:city])
      @neighborhood = Neighborhood.find_by(slug: params[:neighborhood])
      @events = Event.where(city_name: @city.name, neighborhood_name: @neighborhood.name).upcoming

    elsif params[:city]
      @city = City.find_by(slug: params[:city])
      @events = Event.where(city_name: @city.name).upcoming

    else
      @city = City.find_by(name: current_user.city_name)
    	@events = Event.where(city_name: current_user.city_name).upcoming

    end

    @number_of_events = @events.count

    @feedback = Feedback.new

    # geolocalização do usuario
    gon.latitude = current_user.latitude
    gon.longitude = current_user.longitude

    # array com os lugares para o mapa
    gon.events_local_formatted = format_for_map_this(@events)


  end

  def mypersona

    # filtra eventos por persona
    @persona = Persona.find current_user.persona.id
    @events = @persona.events.upcoming     
    @number_of_events = @events.count 

    # geolocalização do usuario
    gon.latitude = current_user.latitude
    gon.longitude = current_user.longitude

    # array com os lugares para o mapa
    gon.events_local_formatted = format_for_map_this(@events)

    render 'index'

  end 


  def myneighborhood

    # filtra eventos por bairro
    @neighborhood = Neighborhood.friendly.find current_user.neighborhood.id
    @events = @neighborhood.events.upcoming
    @number_of_events = @events.count

    # geolocalização do usuario
    gon.latitude = current_user.latitude
    gon.longitude = current_user.longitude

    # array com os lugares para o mapa
    gon.events_local_formatted = format_for_map_this(@events)

    render 'index'

  end  



  def myagenda

    # filtra eventos por bairro
    @events = current_user.agenda_events.upcoming
    @number_of_events = @events.count

    # geolocalização do usuario
    gon.latitude = current_user.latitude
    gon.longitude = current_user.longitude

    # array com os lugares para o mapa
    gon.events_local_formatted = format_for_map_this(@events)

    render 'index'

  end   


private

  def set_event
    @event = Event.find(params[:id])
  end




end
