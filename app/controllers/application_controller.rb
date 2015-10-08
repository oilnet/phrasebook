class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_locale
  before_filter :require_login

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  private
  
  def default_url_options(options = {})
    {locale: I18n.locale}.merge options
  end
  
  def extract_locale_from_accept_language_header
    logger.debug "* Accept-Language: #{http_accept_language.user_preferred_languages.inspect}"
    http_accept_language.compatible_language_from(I18n.available_locales)
  end
  
  def not_authenticated
    redirect_to sign_in_path, alert: "Die gewünschte Funktion steht nur angemeldeten Benutzern zur Verfügung."
  end
end
