json.array!(@neighborhoods) do |neighborhood|
  json.extract! neighborhood, :id, :name, :description, :city_id
  json.url neighborhood_url(neighborhood, format: :json)
end
