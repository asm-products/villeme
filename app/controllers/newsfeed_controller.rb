class NewsfeedController < ApplicationController

  # verifica se o user esta logado
  before_action :is_logged, except: [:index, :city]

  # verifica se a conta esta completa
  before_action :is_invited

  # verifica se a conta esta completa
  before_action :is_complete, except: [:index, :city]

  include Gmaps



  # Layout newsfeed
  layout "three-columns"


  def index

    if current_or_guest_user.nil?
      redirect_to welcome_path
    elsif current_or_guest_user.city_slug
      redirect_to newsfeed_city_path(current_or_guest_user.city_slug) and return
    else
      redirect_to newsfeed_city_path(City.where(launch: true).first.slug) and return
    end

  end

  def city

    if current_or_guest_user.guest?
      render_newsfeed_for_guest_user
    else
      @city = City.find_by(slug: params[:city])
      @events = Event.where(city_name: current_or_guest_user.city_name).upcoming
      @events_today = Event.all_today_in_my_city(current_or_guest_user, limit: 3)
      @events_persona = Event.all_persona_in_my_city(current_or_guest_user, limit: 3)
      @events_neighborhood = Event.all_in_my_neighborhood(current_or_guest_user, limit: 3)

      @number_of_events = @events.count
      @message_for_none_events = "Não há eventos no momento em #{@city.name}."
      @feedback = Feedback.new

      # user location
      gon.latitude = current_or_guest_user.latitude
      gon.longitude = current_or_guest_user.longitude

      # array with places for map navigator on sidebar
      gon.events_local_formatted = format_for_map_this(@events)

      render :index
    end

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

    render :index

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

    render :index

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

    render :index

  end


  private

  def set_event
    @event = Event.find(params[:id])
  end

  def render_newsfeed_for_guest_user

    @city = City.find_by(slug: params[:city])
    @events = Event.where(city_name: @city.name).upcoming
    @events_today = Event.all_today_in_my_city(current_or_guest_user, limit: 3)
    @events_persona = Event.all_persona_in_my_city(current_or_guest_user, limit: 3)
    @events_neighborhood = Event.all_in_my_neighborhood(current_or_guest_user, limit: 3)

    @number_of_events = @events.count

    @message_for_none_events = "Não há eventos no momento em #{@city.name}."
    @feedback = Feedback.new

    # city location
    gon.latitude = @city.latitude
    gon.longitude = @city.longitude

    # array with places for map navigator on sidebar
    gon.events_local_formatted = format_for_map_this(@events)

    render :index
  end




end
