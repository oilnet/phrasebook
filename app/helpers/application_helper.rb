module ApplicationHelper
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
      link_to fa_icon('sign-out'), :sign_out
    else
      link_to fa_icon('sign-in'), :sign_in
    end
  end
  
  def link_to_sign_up
    unless current_user
      link_to fa_icon('user-plus'), :sign_up
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
