class InviteMailer < ActionMailer::Base

	default content_type: "text/html"

  def welcome_email(invite)
    @invite = invite
    @url  = 'http://www.villeme.com/'
    @city = City.find_by(name: @invite.city_name)
    @city_goal = @city.goal
    @invites_in_this_city = Invite.where(city_name: @city_name).count

    set_message_about_quantity_of_invites

    mail(
    	to: @invite.email, 
    	from: 'jonataseduardo@villeme.com',
    	subject: 'Bem-vindo ao Villeme!',
    	track_opens: 'true'
  	)
  end

  def send_key(invite)
    @invite = invite
    @key = invite.key
    mail(
      to: @invite.email,
      from: 'jonataseduardo@villeme.com',
      subject: 'Seu convite para o Villeme chegou!',
      track_opens: 'true'
    )
  end

  private

  def set_message_about_quantity_of_invites
    if @city_goal <= 0
      @message = "versão Beta lançada!"
      @city_beta_actived = true
    else
      @message = "<b>#{(@city_goal)}</b> pessoas para ativar o Beta em <b>#{@city.name}</b>".html_safe
    end
  end

end
