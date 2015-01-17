module FacebookOauth

  def find_for_facebook_oauth(auth, signed_in_resource = nil)
    userauth = User.where(:provider => auth.provider, :uid => auth.uid).first

    if userauth.nil?
      associate_user_with_auth(auth, userauth)
    else
      userauth
    end

  end

  private

  def associate_user_with_auth(auth, userauth)
    email, user = find_user_with_auth_email(auth)

    if user.nil?
      user = create_user(auth, email)
    else
      user = update_user(auth, user)
    end

    unless user_associated?(user, userauth)
      associate_user(user, auth)
    end

    user
  end

  def find_user_with_auth_email(auth)
    email = auth.info.email
    user = User.find_by(:email => email) if email
    return email, user
  end

  def associate_user(user, auth)
    user.provider = auth.provider
    user.uid = auth.uid
    user.save!
  end

  def user_associated?(user, userauth)
    if userauth == user
      true
    else
      false
    end
  end

  def update_user(auth, user)
    if user_updated?(auth, user)
      user
    end
  end

  def user_updated?(auth, user)
    user.update_attributes(facebook_avatar: auth.info.image, username: auth.info.nickname.gsub('.', ''), token: auth.credentials.token)
  end

  def create_user(auth, email)
    User.create(name: auth.info.name, email: email, username: auth.info.nickname.gsub('.', ''), password: Devise.friendly_token[0, 8], facebook_avatar: auth.info.image, token: auth.credentials.token)
  end

end
