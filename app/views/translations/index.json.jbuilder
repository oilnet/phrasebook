json.array!(@translations) do |translation|
  json.extract! translation, :id, :phrase_id, :original, :transliteration, :rec_filename, :rec_filetype, :rec_contents, :lang, :country
  json.url translation_url(translation, format: :json)
end
