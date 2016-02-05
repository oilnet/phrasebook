class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_locale
  before_action :set_languages
  before_filter :require_login
  before_filter :set_actionmailer_host
  
  helper_method :admin?

  def admin?
    current_user && current_user.admin?
  end

  def set_locale
    if params[:locale] && params[:locale].length > 2
      redirect_to url_for("/#{I18n.default_locale}/#{params[:locale]}")
    else
      I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
      # logger.debug "*** Locale set to '#{I18n.locale}'"
    end
  end

  private
  
  def default_url_options(options = {})
    {locale: I18n.locale}.merge options
  end
  
  def extract_locale_from_accept_language_header
    # logger.debug "*** Accept-Language: #{http_accept_language.user_preferred_languages.inspect}"
    http_accept_language.compatible_language_from(I18n.available_locales)
  end
  
  def not_authenticated
    redirect_to sign_in_path, alert: "Die gewünschte Funktion steht nur angemeldeten Benutzern zur Verfügung."
  end
  
  def set_actionmailer_host
    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end
  
  def set_languages
    @languages = [:de]
  end
end
