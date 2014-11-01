# encoding: utf-8

class WelcomeController < ApplicationController

	layout 'welcome'

  def index

    if user_signed_in?
      if current_user.invited 
        redirect_to newsfeed_path and return
      end
    end

  	if params[:key]
  		# verifica o convite
  		invite_user = Invite.where(key: params[:key]).first

  		# verifica se o user ja existe
  		user_exist = User.where(email: invite_user.email).first

  		# cria o user caso não exista
  		if user_exist.blank?
  			new_user = User.create(name: invite_user.name, email: invite_user.email, password: Devise.friendly_token[0,8], city_id: invite_user.city, persona_id: invite_user.persona, invited: true)
  			redirect_to "http://www.villeme.com/users/auth/facebook" and return
  		else
  			user_exist.update_attributes(city_id: invite_user.city, persona_id: invite_user.persona, invited: true)
  			redirect_to "http://www.villeme.com/users/auth/facebook" and return
  		end

  		@invite = Invite.new

 		else

  		@invite = Invite.new
  	end

    @cities = City.limit(5).order(:name)

    @invites = Invite.all

  end




end
