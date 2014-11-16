class ProfilesController < ApplicationController
  
   # verifica se o user esta logado
  before_action :is_logged

  layout 'centralize-lg'



  def events

		if user_signed_in?
			@events = current_user.events
		else
			redirect_to newsfeed_path, flash: "Sem eventos"
		end


  end

  def places

  end

end
