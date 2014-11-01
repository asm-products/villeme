json.array!(@weeks) do |week|
  json.extract! week, :id, :name, :slug, :binary
  json.url week_url(week, format: :json)
end
