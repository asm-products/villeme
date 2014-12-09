class InviteMailer < ActionMailer::Base

	default content_type: "text/html"

  def welcome_email(invite)
    @invite = invite
    @url  = 'http://www.villeme.com/'
    @city = @invite.city
 
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

end
