# encoding: utf-8


class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :schedule]

  # access for only logged users
  before_action :is_logged, only: [:new, :edit, :create, :update]

  # access only for admin users
  before_action :is_admin, only: [:index, :aprove, :destroy]

  layout 'three-columns', except: :index

  

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    render layout: 'centralize-lg'
  end



  # GET /events/1
  # GET /events/1.json
  def show

    if user_signed_in?
      @distance = current_user.distance_to?(@event, :transport)
    end

    @tip = Tip.new

    # geolocalization of event
    gon.latitude = @event.latitude.blank? ? @event.place.latitude : @event.latitude
    gon.longitude = @event.longitude.blank? ? @event.place.longitude : @event.longitude

    # array with places for map
    gon.events_local_formatted = events_local_formatted    

  end



  # GET /events/new
  def new

    if current_user.city.blank?
      return redirect_to :back, alert: 'Você precisa estar com o perfil completo para criar um evento!'
    else
      @city = City.find current_user.city
    end

    @event = current_user.events.build
    place = @event.build_place

    gon_variables

  end




  # GET /events/1/edit
  def edit

    @event.build_place if @event.place.nil?

    places_array = Array.new

    Place.all.each do |place|
      places_array << {label: place.name, value: place.id} 
    end

    gon.places_array = places_array

    gon.latitude = @event.latitude.blank? ? current_user.city.latitude : @event.latitude
    gon.longitude = @event.longitude.blank? ? current_user.city.longitude : @event.longitude
  end




  # POST /events
  # POST /events.json
  def create


    @event = current_user.events.create event_params
    place_name_from_form = params[:event][:place_attributes][:name]

    unless place_name_from_form.nil?

      place = Place.find_by name: place_name_from_form

      if place.nil?
        place = Place.new name: place_name_from_form
        @event.copy_attributes_to place
        @event.place = place

      else
        place.copy_attributes_to @event
        @event.place = place
      end

    end


    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'O evento foi  criado com sucesso!' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new', alert: 'O evento não pode ser criado, arrume as informações abaixo.' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end

  end






  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update

    @event.update_attributes(event_params)

    place = Place.find_by(name: params[:event][:place_attributes][:name])
    @event.place = place

    if @event.address.blank? and place.nil? == false
      if @event.place.nil?
        geocoder_place_address_and_copy_attributes_to_event
      else
        copy_place_attributes_to_event      
      end
    end


    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'O evento foi atualizado com sucesso!' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new', alert: 'O evento não pode ser atualizado, arrume as informações abaixo.' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end

  end






  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end



  # PUT /events/aprove/1.json
  def aprove
    @event = Event.find params[:id]
    @event.moderate = 1
    @event.save!
    render js: "alert('Evento aprovado!');"
  end


  def schedule

    expire_fragment [@event, "agenda"]

    if agended(@event)
      current_user.agenda_events.delete(@event)      
      render json: {agended: false, event: "event-#{@event.id}", count: current_user.agenda_events.count, agended_by_count: @event.agended_by_count[:count], new_title: @event.agended_by_count[:text]}
    else 
      current_user.agenda_events << @event      
      render json: {agended: true, event: "event-#{@event.id}", count: current_user.agenda_events.count, agended_by_count: @event.agended_by_count[:count], new_title: @event.agended_by_count[:text]}
    end
  end



  def full_description
    @event = Event.friendly.find params[:event]    
    render json:{full_description: @event.description}
  end


  private



  def set_event
    # @event = Event.find(params[:id])
    @event = Event.friendly.find(params[:id])
  end


  def set_city
    if @event.place.neighborhood.city.nil?
      @city = current_user.city
    else
      @city = @event.place.neighborhood.city
    end
  end


  def event_params
    params.require(:event).permit(
        :name,
        :description,
        :address,
        :number,
        :date_start,
        :date_finish,
        :cost,
        :cost_details,
        :hour_start_first,
        :hour_start_second,
        :hour_start_third,
        :hour_start_fourth,
        :hour_start_fifth,
        :hour_start_sixth,
        :hour_finish_first,
        :hour_finish_second,
        :hour_finish_third,
        :hour_finish_fourth,
        :hour_finish_fifth,
        :hour_finish_sixth,
        :latitude,
        :longitude,
        :place_id,
        :price_id,
        :persona_id,
        :subcategory_id,
        :image,
        :link,
        :email,
        :phone,
        :category_ids => [],
        :week_ids => []
    )
  end


  # variables javascript for views
  def gon_variables
    if user_signed_in?
      gon.latitude = @event.latitude.blank? ? current_user.city.latitude : @event.latitude
      gon.longitude = @event.longitude.blank? ? current_user.city.longitude : @event.longitude
      gon.city = @city.name     
    end

    places_array = Array.new
    Place.all.each do |place|
      places_array << {label: place.name, value: place.id} 
    end
    gon.places_array = places_array


  end



  def set_events_local
    @events_local = Hash.new
    @events_local[@event.name] = {latitude: @event.latitude.blank? ? @event.place.latitude : @event.latitude , longitude: @event.longitude.blank? ? @event.place.longitude : @event.longitude , address: @event.address, url: event_url(@event), strong_category: strong_category(@event, 'slug')}
    @events_local
  end




  def events_local_formatted 
    letter = ('A'..'Z').to_a
    i = 0
    @events_local_array = Array.new

    set_events_local.each do |index, value|
      @events_local_array << {latLng:[value[:latitude].to_s, value[:longitude].to_s], id: letter[i].to_s, data: {link: value[:url].to_s, name: index.to_s, address: value[:address] }, options: {icon: "/images/marker-default-" + value[:strong_category].to_s.parameterize  + ".png"}}
      i += 1
    end

    @events_local_array << {latLng:[current_user.latitude, current_user.longitude], data: current_user.name.to_s, options: {icon: "/images/marker-default-home.png"}}

    @events_local_array
  end



end
