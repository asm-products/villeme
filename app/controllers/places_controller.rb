class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # acesso somente para admin
  before_action :is_admin  

  layout "centralize-lg"

  # GET /places
  # GET /places.json
  def index
    @places = Place.all
  end

  # GET /places/1
  # GET /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = Place.new

    if user_signed_in?
      gon.latitude = @place.latitude.blank? ? current_user.city.latitude : @place.latitude
      gon.longitude = @place.longitude.blank? ? current_user.city.longitude : @place.longitude    
    end  
  end

  # GET /places/1/edit
  def edit

    gon.latitude = @place.latitude.blank? ? current_user.city.latitude : @place.latitude
    gon.longitude = @place.longitude.blank? ? current_user.city.longitude : @place.longitude

  end

  # POST /places
  # POST /places.json
  def create

    # Cria o lugar com os parametros enviados pelo formulario
    @place = Place.new(place_params)

    # Busca o 'id' do bairro selecionado no mapa
    @neighborhood = Neighborhood.find_by(name: place_params[:neighborhood])


    unless @neighborhood.blank?
      @place.neighborhood = @neighborhood
    end

    # Salva o lugar 
    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render action: 'show', status: :created, location: @place }
      else
        format.html { render action: 'new' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update


    # Busca o bairro selecionado no mapa
    @neighborhood = Neighborhood.find_by(name: place_params[:neighborhood])


    unless @neighborhood.blank?
      @place.neighborhood = @neighborhood
    end

    
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Lugar cadastrado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :description, :neighborhood, :latitude, :longitude, :address, :full_address, :number, :category_ids => [])
    end
end
