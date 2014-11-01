class ProfilesController < ApplicationController
  
   # verifica se o user esta logado
  before_action :is_logged

  layout 'centralize-lg'



  def events

  	# mostra os eventos somente para/e do o usuario logado
  	if current_user.username == params[:id] 

	  	# cria o usuario com o :id que sera requisitado os eventos
	  	@user = current_user

	  	if @user
	  		@events = @user.events
	  	else
	  		render file: 'public/404', status: 404, formats: [:html]
	  	end   

	  else
	  	render file: 'public/404', status: 404, formats: [:html]
  	end	

  end

  def places

  end

end
