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

    if current_user.city_slug
      redirect_to newsfeed_city_path(current_user.city_slug) and return
    else
      @city = City.find_by(name: current_user.city_name)
    	@events = Event.where(city_name: current_user.city_name).upcoming

      @number_of_events = @events.count
      @message_for_none_events = "Não há eventos no momento em #{@city.try(:name)}."
      @feedback = Feedback.new

      # user location
      gon.latitude = current_user.latitude
      gon.longitude = current_user.longitude

      # array with places for map navigator on sidebar
      gon.events_local_formatted = format_for_map_this(@events)
    end

  end

  def city
    @city = City.find_by(slug: params[:city])
    @events = Event.where(city_name: @city.name).upcoming
    @number_of_events = @events.count

    @number_of_events = @events.count
    @message_for_none_events = "Não há eventos no momento em #{@city.name}."
    @feedback = Feedback.new

    # user location
    gon.latitude = current_user.latitude
    gon.longitude = current_user.longitude

    # array with places for map navigator on sidebar
    gon.events_local_formatted = format_for_map_this(@events)

    render :index
  end

  def neighborhood
    @city = City.find_by(slug: params[:city])
    @neighborhood = Neighborhood.find_by(slug: params[:neighborhood])
    @events = Event.where(city_name: @city.name, neighborhood_name: @neighborhood.name).upcoming
    @number_of_events = @events.count
    @message_for_none_events = "Não há eventos no momento em #{@neighborhood.name}."
    render :index
  end

  def category
    @category = Category.friendly.find params[:category]
    @events = @category.events.upcoming
    @number_of_events = @events.count
    @message_for_none_events = "Não há eventos no momento em #{@category.name}."
    render :index
  end

  def mypersona

    # filter events from user persona
    @persona = Persona.find current_user.persona
    @events = @persona.events.upcoming     
    @number_of_events = @events.count
    @message_for_none_events = "Não há eventos no momento em #{@persona.name}."

    # user location
    gon.latitude = current_user.latitude
    gon.longitude = current_user.longitude

    # array with places for map navigator on sidebar
    gon.events_local_formatted = format_for_map_this(@events)

    render 'index'

  end 


  def myneighborhood

    # filter events from user neighborhood
    @neighborhood = Neighborhood.friendly.find current_user.neighborhood.id
    @events = @neighborhood.events.upcoming
    @number_of_events = @events.count
    @message_for_none_events = "Não há eventos no momento em #{@neighborhood.name}."

    # user location
    gon.latitude = current_user.latitude
    gon.longitude = current_user.longitude

    # array with places for map navigator on sidebar
    gon.events_local_formatted = format_for_map_this(@events)

    render 'index'

  end  



  def myagenda

    # filter events from user agenda
    @events = current_user.agenda_events.upcoming
    @number_of_events = @events.count
    @message_for_none_events = "Não há eventos no momento em sua agenda."

    # user location
    gon.latitude = current_user.latitude
    gon.longitude = current_user.longitude

    # array with places for map navigator on sidebar
    gon.events_local_formatted = format_for_map_this(@events)

    render 'index'

  end   


private

  def set_event
    @event = Event.find(params[:id])
  end




end
