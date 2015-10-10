module PhrasesHelper
  def show_tags(phrase)
    html = ''
    phrase.tags.split(' ').each do |t|
      html += content_tag :span, t.gsub('_', ' ').humanize, class: :label
    end
    html
  end
  
  def link_to_new_phrase
    link_to(
      "Nichts gefunden? Vorschlag machen!",
      new_phrase_path,
      {id: :new_phrase, class: 'full-width button'}
    )
  end
end
