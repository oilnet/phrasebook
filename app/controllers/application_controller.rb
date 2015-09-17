class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
  end

  def authorize_user!
  end

  private

  def current_user
  end

  def set_locale
  end
end
