module PhrasesHelper
  def show_tags(phrase)
    html = ''
    phrase.tags.split(' ').each do |t|
      html += content_tag :span, t.gsub('_', ' ').humanize, class: :label
    end
    html
  end
end
