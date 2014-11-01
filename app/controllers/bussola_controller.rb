class BussolaController < ApplicationController

  # acesso somente para users logados
  before_action :is_logged  

  layout 'centralize'

  def city
  	@cities = City.all
  end

  def neighborhood
  	@neighborhoods = Neighborhood.all
  end

  def selecionado
  	if params[:city]
  		redirect_to new_event_path(params[:city])
  	else
    	redirect_to newsfeed_path
    end
  end


  private

    def bussola_params
      params.require(:bussola).permit(:city)
    end

end
