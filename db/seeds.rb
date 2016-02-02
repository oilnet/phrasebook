SupportedLanguage.destroy_all

LANGS = [
  [:de, 'Deutsch'],
  [:ar, 'اللغة العربية']
]

puts "supported languages:"
LANGS.each do |language, name|
  puts language
  SupportedLanguage.create(language: language, name: name)
end
