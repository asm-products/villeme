json.array!(@cities) do |city|
  json.extract! city, :id, :name, :description
  json.url city_url(city, format: :json)
end
