module ApplicationHelper
  def controller_as_id
    params[:controller].gsub('/', '_')
  end
  
  def model_as_id 
    params[:controller].split('/').last.underscore.singularize
  end

  def icontext(key)
    icon = key.to_s
    case key
      when :record    then icon = 'microphone'
      when :overwrite then icon = 'microphone'
    end
    key_i18n = t(".#{key}")
    "#{fa_icon(icon)}&nbsp;#{key_i18n}"
  end

  def controller_and_action
    "#{params[:controller]}_#{params[:action]}"
  end
  
  def font_list
    {
      google: [
        'Poiret One',
        'PT Sans', # Sans
        'PT Serif', # Serif
        'Lobster',
        'Abel',
        'Pacifico',
        'Dancing Script', # Serif, handwriting
        'Josefin Slab', # Serif, 1930's-style
        'Hammersmith One',
        'Lateef', # Arabic
        'Amiri', # Arabic
        'Scheherazade', # Arabic
        'Open Sans', # Sans, humanist
        'Arvo', # Serif, geometric slab
        'Lato', # Sans, fancy matter-of-fact
        'Vollkorn', # Serif
        'Abril', # Sans
        'Old Standard TT', # Serif, typewriter-style
        'Droid Sans', # Sans, humanist
        'Muli', # Sans, sieht so ein bisschen wie der Erstentwurf #3 aus
        'Open Sans' # Das, was Daniel verwendet hat
      ]
    }
  end
  
  def link_to_directory
    link_to(
      fa_icon('map-signs'),
      page_path(:tag_directory), 
      class: 'large button', 
      title: "Themenkatalog"
    )
  end
  
  def link_to_phraselist
    link_to(
      fa_icon('list'),
      phrases_path,
      class: 'large button', 
      title: "Phrasenliste"
    )
  end
  
  def link_to_imprint
    link_to(
      fa_icon('info-circle'), 
      page_path(:imprint), 
      class: 'large button', 
      title: "Impressum"
    )
  end
  
  def link_to_menu_item(text, link = {})
    # Remove first 3 characters of string, substitute all forward
    # slashes with dashes, then take everything left of the first
    # question mark, should one exist.
    controller = link[4..-1].gsub('/', '_').split('?').first
    # The idea is that the <body> tag has the controller as its
    # idea, so by using "body#foobar a.foobar" (or more abstract,
    # "body##{controller_as_id} a.#{controller_as_id}" you can
    # always select the link representing the current controller.
    link_to(
      text,
      link,
      {class: "button #{controller}"}
    )
  end
  
  def link_to_sign_in_or_out
    if current_user
      if admin? && !params[:controller].include?('admin')
        icon = 'pencil-square-o'
        link = admin_phrases_path
        text = 'Redaktion/Backoffice'
      else
        icon = 'sign-out'
        link = :sign_out
        text = 'Abmelden (Benutzercookie wird gelöscht)'
      end
    else
      icon = 'sign-in'
      link = :sign_in
      text = 'Mit Benutzername und Passwort anmelden'
    end
    link_to(fa_icon(icon), link, class: 'button large', title: text, 'data-turbolinks': false)
  end
  
  def link_to_sign_up
    unless current_user
      link_to(
        fa_icon('user-plus'), 
        :sign_up, 
        class: 'large button',
        title: "Neues Benutzerkonto anlegen"
      )
    end
  end
  
  def show_flashes
    html = ''
    if flash.any?
      flash.each do |severity, msg|
        html = "<div data-alert class='#{severity} alert-box radius'>#{msg}<a href='#' class='close'>#{fa_icon('close')}</a></div>".html_safe
      end
    end
    html
  end
  
  def tag_path(*tags)
    phrase_path(tags)
  end
  
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
  
  def link_to_audio(translation, side = nil)
    if translation.recording_data
      link_to(
        content_tag('span', translation.text),
        translation_path(translation, format: :mp3),
        {class: "audio_recording #{side}"}
      )
    else
      content_tag('span', translation.text, {class: side, lang: translation.language})
    end
  end
  
  def phrase_heading
    if @phrase.new_record?
      "Neue Phrase"
    else
      "Phrase \"#{@phrase.main_translation.text}\""
    end
  end
  
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
  
  def button_play_stop_tag(obj)
  button_tag(
    icontext(:play).html_safe,
    id: :play_stop, 
    class: :button, 
    type: :button,
    name: nil,
    style: ('display:none;' unless obj.recording_data),
    data: {
      play: icontext(:play), 
      stop: icontext(:stop)
    })
  end
  
  def button_record_stop_tag(obj, params={overwrite: false})
  label = (params[:overwrite] ? :overwrite : :record)
  button_tag(
    icontext(label).html_safe, 
    id: :record, 
    class: :button, 
    type: :button, 
    name: nil, 
    data: {
      record: icontext(label), 
      stop: icontext(:stop)
    })
  end
end
