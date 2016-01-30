class Admin::AdminController < ApplicationController
  before_action :require_admin
  layout 'admin'

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
  
  # Overwriting AdminController method
  # to prevent a redirect loop on logout.
  def redirect_logged_in_admin
    nil
  end
end
