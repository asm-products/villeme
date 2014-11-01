json.array!(@places) do |place|
  json.extract! place, :id, :name, :description, :neighborhood_id
  json.url place_url(place, format: :json)
end
