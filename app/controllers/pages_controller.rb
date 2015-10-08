class PagesController < ApplicationController
  skip_before_filter :require_login

  def index
    redirect_to action: :show, id: :welcome
  end

  def show
    render params[:id]
  end
end
