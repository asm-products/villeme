json.array!(@countries) do |country|
  json.extract! country, :id, :name, :latitude, :longitude, :code
  json.url country_url(country, format: :json)
end
