module TranslationsHelper
  def selected_phrase_id
    (params[:translation] && params[:translation][:phrase_id]) || @translation.phrase_id || @phrases.first
  end
  
  def selected_language
    (params[:translation] && params[:translation][:language]) || @translation.language
  end
  
  def selected_source_country
    (params[:translation] && params[:translation][:source_country]) || @translation.source_country
  end
  
  def next_untranslated_phrase
    Phrase.all.count > 1 && Phrase.untranslated.any? && Phrase.untranslated.first != @translation.phrase
  end
end
