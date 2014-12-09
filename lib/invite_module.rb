module InviteModule

  include GeocodedActions

  def create_user_from_invite(key)
    invite = Invite.where(key: key).first
    user = User.where(email: invite.email).first

    if user_not_exist?(user)
      user_create(invite)
      redirect_to "http://www.villeme.com/users/auth/facebook" and return
    else
      user_update(invite, user)
      redirect_to "http://www.villeme.com/users/auth/facebook" and return
    end
  end


  # helpers methods

  def user_not_exist?(user)
    user.blank?
  end

  def user_create(invite)
    user = User.create(name: invite.name,
                email: invite.email,
                password: Devise.friendly_token[0, 8],
                persona_id: invite.persona,
                invited: true)

    invite.copy_attributes_to(user)
  end

  def user_update(invite, user)
    user.update_attributes(persona_id: invite.persona,
                           invited: true)

    invite.copy_attributes_to(user)
  end

end
