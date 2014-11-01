class NotifyController < ApplicationController


	# atualiaza data e horario da verificação das noticações
  def bell

  	# cria a notificação se não existir
  	if current_user.notify.nil?
  		current_user.create_notify(bell_view: DateTime.current)
  	
  	# atualiza a notificações se existir
  	else
  		current_user.notify.update_attributes(bell_view: DateTime.current)
	  end

  	if current_user.save
  		render json: {success: true}
  	else
			render json: {success: false}
  	end

  end




  # atualiaza data e horario da verificação das noticações
  def newsfeed

    # cria a notificação se não existir
    if current_user.notify.nil?
      current_user.create_notify(newsfeed_view: DateTime.current)
    
    # atualiza a notificações se existir
    else
      current_user.notify.update_attributes(newsfeed_view: DateTime.current)
    end

    if current_user.save
      render json: {success: true}
    else
      render json: {success: false}
    end

  end




end
