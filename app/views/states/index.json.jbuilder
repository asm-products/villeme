json.array!(@states) do |state|
  json.extract! state, :id, :name, :latitude, :longitude, :country, :country_code, :code
  json.url state_url(state, format: :json)
end
