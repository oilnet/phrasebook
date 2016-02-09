class PagesController < ApplicationController
  skip_filter :require_login

  # GET /pages
  def index
    redirect_to action: :show, id: :welcome
  end

  # GET /phrases/id, where id is app/views/pages/*.html.haml
  def show
    render params[:id]
  end
end
