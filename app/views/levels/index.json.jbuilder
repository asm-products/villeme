json.array!(@levels) do |level|
  json.extract! level, :id, :name, :slug, :description, :nivel, :url, :points
  json.url level_url(level, format: :json)
end
