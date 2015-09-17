json.array!(@phrases) do |phrase|
  json.extract! phrase, :id, :text, :tags, :rec_filename, :rec_filetype, :rec_contents, :usefulness
  json.url phrase_url(phrase, format: :json)
end
