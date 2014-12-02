
# config/initializers/koala.rb
# Simple approach
Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    raise 'application id and/or secret are not specified in the envrionment' unless '568047899941238' && 'ab34e8bcc6550300cc454369089d4db8'
    initialize_without_default_settings(('568047899941238').to_s, ('ab34e8bcc6550300cc454369089d4db8').to_s, args.first)
  end

  alias_method_chain :initialize, :default_settings
end