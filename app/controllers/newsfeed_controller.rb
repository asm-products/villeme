class NewsfeedController < ApplicationController
  
  # verifica se o user esta logado
  before_action :is_logged

  # verifica se a conta esta completa
  before_action :is_invited

  # verifica se a conta esta completa
  before_action :is_complete





	# Layout newsfeed
	layout "three-columns"


  def index
  	
    if params[:category]

      # filtra os eventos por categoria
      @category = Category.friendly.find params[:category]
      @events = @category.events.upcoming

    elsif params[:neighborhood]

      # filtra eventos por bairro
      @neighborhood = Neighborhood.friendly.find params[:neighborhood]
      @events = @neighborhood.events.upcoming 
   
    else

      # pega todos os eventos
    	@events = Event.upcoming
    end

    @number_of_events = @events.count

    @feedback = Feedback.new



    # geolocalização do usuario
    gon.latitude = current_user.latitude
    gon.longitude = current_user.longitude

    # array com os lugares para o mapa
    gon.events_local_formatted = events_local_formatted

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
    gon.events_local_formatted = events_local_formatted

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
    gon.events_local_formatted = events_local_formatted

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
    gon.events_local_formatted = events_local_formatted

    render 'index'

  end   


private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_events_local
    @events_local = Hash.new
    @events.each do |event|
      @events_local[event.name] = {latitude: event.latitude.blank? ? event.place.latitude : event.latitude , longitude: event.longitude.blank? ? event.place.longitude : event.longitude , address: event_address(event), url: event_url(event), strong_category: strong_category(event, 'slug')}
    end
    return @events_local
  end


  def events_local_formatted 
    letter = ('A'..'Z').to_a
    i = 0
    @events_local_array = Array.new

    set_events_local.each do |index, value|
      @events_local_array << {latLng:[value[:latitude].to_s, value[:longitude].to_s], id: letter[i].to_s, data: {link: value[:url].to_s, name: index.to_s, address: value[:address] }, options: {icon: "/images/marker-default-" + value[:strong_category].to_s.parameterize  + ".png"}}
      i += 1
    end

    set_user_local

    return @events_local_array
  end


  def set_user_local
    @events_local_array << {latLng:[current_user.latitude, current_user.longitude], data: current_user.name.to_s, options: {icon: "/images/marker-default-home.png"}}
  end









end
