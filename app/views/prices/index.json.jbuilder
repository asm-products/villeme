json.array!(@prices) do |price|
  json.extract! price, :id, :name, :description
  json.url price_url(price, format: :json)
end
