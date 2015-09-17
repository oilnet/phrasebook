json.array!(@searches) do |search|
  json.extract! search, :id, :text, :count
  json.url search_url(search, format: :json)
end
