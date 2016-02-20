class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_locale
  before_filter :require_login, except: [:routing_error]
  before_filter :set_actionmailer_host
  
  helper_method :admin?

  # http://stackoverflow.com/questions/18359088/custom-error-handling-with-rails-4-0
  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  # http://stackoverflow.com/questions/23351826/doublerendererror-in-rails-4-1-when-rescuing-from-invalidcrossoriginrequest
  rescue_from 'ActionController::InvalidCrossOriginRequest' do |exception|
    logger.debug "*** Rescuing from invalid cross origin request. (#{params.inspect})"
    self.response_body = nil
    render nothing: true, status: 400
  end

  # http://stackoverflow.com/questions/25841377/rescue-from-actioncontrollerroutingerror-in-rails4
  unless Rails.application.config.consider_all_requests_local
    [ActionController::RoutingError,
     ActionController::UnknownController,
     ActiveRecord::RecordNotFound,
     I18n::InvalidLocale].each do |error|
      rescue_from error do |exception|
        logger.debug "*** Rescuing from request asking for a non-existing resource. (#{params.inspect})"
        render file: "#{Rails.root}/public/404", layout: false, status: 404
      end
    end
  end

  def admin?
    current_user && current_user.admin?
  end

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
    logger.debug "*** Locale set to '#{I18n.locale}'"
  end

  private

  def default_url_options(options = {})
    if I18n.default_locale != I18n.locale
      {locale: I18n.locale}.merge options
    else
      {locale: nil}.merge options
    end
  end
  
  def extract_locale_from_accept_language_header
    logger.debug "*** Accept-Language: #{http_accept_language.user_preferred_languages.inspect}"
    http_accept_language.compatible_language_from(I18n.available_locales)
  end
  
  def not_authenticated
    redirect_to sign_in_path, alert: "Die gewünschte Funktion steht nur angemeldeten Benutzern zur Verfügung."
  end
  
  def set_actionmailer_host
    ActionMailer::Base.default_url_options = {:host => request.host_with_port}
  end
end
