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
        'Muli' # Sans, sieht so ein bisschen wie der Erstentwurf #3 aus
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
  
  def show_flashes
    if flash.any?
      content_tag :div, id: :flash do
        flash.each do |severity, msg|
          content_tag :span, msg, class: severity
        end
      end
    end
  end
end
