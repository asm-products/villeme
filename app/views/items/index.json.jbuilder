json.array!(@items) do |item|
  json.extract! item, :id
  json.url item_url(item, format: :json)
end
