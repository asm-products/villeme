json.array!(@invites) do |invite|
  json.extract! invite, :id, :user_id, :email, :name, :city, :persona, :persona_suggest, :city_suggest, :key
  json.url invite_url(invite, format: :json)
end
