module ApplicationHelper
  def icontext(key)
    icon = key.to_s
    case key
      when :record    then icon = 'microphone'
      when :overwrite then icon = 'microphone'
    end
    key_i18n = t(".#{key}")
    "#{fa_icon(icon)}&nbsp;#{key_i18n}"
  end
  
  def button_play_stop_tag(obj)
  button_tag(
    icontext(:play).html_safe,
    id: :play_stop, 
    class: :button, 
    type: nil,
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
    type: nil, 
    name: nil, 
    data: {
      record: icontext(label), 
      stop: icontext(:stop)
    })
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
  
  def link_to_sign_in_or_out
    if current_user
      link_to(
        fa_icon('sign-out'),
        :sign_out, 
        class: 'large button',
        title: "Abmelden"
      )
    else
      link_to(
        fa_icon('sign-in'),
        :sign_in,
        class: 'large button',
        title: "Anmelden"
      )
    end
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
end
