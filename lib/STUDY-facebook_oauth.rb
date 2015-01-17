def self.find_for_facebook_oauth(auth, signed_in_resource = nil)


  # Get the identity and user if they exist
  userauth = User.where(:provider => auth.provider, :uid => auth.uid).first

  if userauth.nil?

    # Get the existing user by email if the OAuth provider gives us a verified email
    # If the email has not been verified yet we will force the user to validate it
    email = auth.info.email
    user = User.find_by(:email => email) if email

    # Create the user if it is a new registration
    if user.nil?
      user = User.create(name: auth.info.name, email: email, username: auth.info.nickname.gsub('.',''), password: Devise.friendly_token[0,8], facebook_avatar: auth.info.image, token: auth.credentials.token)
    else
      user.update_attributes(facebook_avatar: auth.info.image, username: auth.info.nickname.gsub('.',''), token: auth.credentials.token)
    end

    # Associate the identity with the user if not already
    if userauth != user
      user.provider = auth.provider
      user.uid = auth.uid
      user.save!
    end

    user

  else
    userauth
  end

end
