module ApplicationHelper
  def image_tag(img , options={})
    img = 'missing.png' unless img.present?
    super(img, options)
  end
  
  def display_none_if_no_image
    display = :block
    display = :none unless @phrase.image_data
    "display: #{display};"
  end

  def link_to_menu_item(text, link = '', options = {})
    # Make path to controller into something that works as a CSS 
    # class and also matches the <body>'s CSS id. Works for frontend
    # and admin controller paths.
    controller = link.gsub(/\/([a-z]{2}\/|)(admin|)(\/|)([a-z]*)(\/|)([a-z]*)/) do
      [$2, $4, $6].reject(&:blank?).join '_'
    end
    # The idea is that the <body> tag has the controller as its
    # idea, so by using "body#foobar a.foobar" (or more abstract,
    # "body##{controller_as_id} a.#{controller_as_id}" you can
    # always select the link representing the current controller.
    link_to(
      text,
      link,
      options.merge({class: "button #{controller}"})
    )
  end
  
  def controller_as_id
    params[:controller].gsub('/', '_')
  end
  
  def model_as_id 
    params[:controller].split('/').last.underscore.singularize
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
  
  def link_to_sign_in_or_out
    if current_user
      if admin? && !params[:controller].include?('admin')
        icon = 'pencil-square-o'
        link = admin_phrases_path
        text = 'Redaktion/Backoffice' # TODO: i18n!
      else
        icon = 'sign-out'
        link = :sign_out
        text = 'Abmelden (Benutzercookie wird gelöscht)' # TODO: i18n!
      end
    else
      icon = 'sign-in'
      link = :sign_in
      text = 'Mit Benutzername und Passwort anmelden' # TODO: i18n!
    end
    link_to(fa_icon(icon), link, class: 'button', title: text, 'data-turbolinks': false)
  end
  
  def show_flashes
    html = ''
    if flash.any?
      flash.each do |severity, msg|
        html = "<div data-alert class='#{severity} alert-box flash radius'>#{msg}<a href='#' class='close'>#{fa_icon('close')}</a></div>".html_safe
      end
    end
    html
  end
  
  def tag_path(*tags)
    phrases_path + "?tags=#{tags.join(',')}"
  end
  
  def show_tags(phrase)
    html = ''
    phrase.tags.split(' ').each do |t|
      html += content_tag :span, t.gsub('_', ' ').humanize, class: 'label badge'
    end
    html
  end
  
  def link_to_audio(translation, side = nil)
    if translation.recording_data
      path = translation_path(translation, format: :mp3)
      link_to(
        content_tag('span', fa_icon('volume-up')+' '+translation.text),
        path,
        {class: "audio_recording #{side}"}
      )+content_tag('audio', nil, {src: path, controls: false, preload: :none})
    else
      content_tag('span', translation.text, {class: side, lang: translation.language})
    end
  end
  
  def phrase_heading
    if @phrase.new_record?
      'Neue Phrase' # TODO: i18n!
    else
      "Phrase <em>#{@phrase.main_translation.text}</em>".html_safe # TODO: i18n!
    end
  end

  # Mapping semantic keys to FontAwesome icon names.
  def icontext(key)
    icon = key.to_s
    case key
      when :record    then icon = 'microphone'
      when :overwrite then icon = 'microphone'
    end
    key_i18n = t(".#{key}")
    fa_icon(icon)+' '+key_i18n
  end
  
  def link_to_play_stop(obj)
    link_to(
      icontext(:play),
      '#',
      id: "play_stop_#{obj.id}",
      class: 'play_stop button',
      style: ('display: none;' unless obj.recording_data),
      data: {
        # Encode the HTML so it doesn't mess things up.
        play: "#{icontext(:play)}",
        stop: "#{icontext(:stop)}"
      }
    )
  end
  
  def link_to_record_stop(obj, params={overwrite: false})
    label = (params[:overwrite] ? :overwrite : :record)
    link_to(
      icontext(label),
      '#',
      id: "record_stop_#{obj.id}",
      class: 'record_stop button',
      data: {
        # Again encode the HTML by putting it inside a string.
        record: "#{icontext(label)}",
        stop:   "#{icontext(:stop)}"
      }
    )
  end
end
