class PagesController < ApplicationController
  skip_filter :require_login

  # GET /pages
  def index
    redirect_to root_path
  end

  # GET /phrases/id, where id is app/views/pages/*.html.haml
  def show
    if File.exist?(File.join('app', 'views', 'pages', "#{params[:id]}.html.haml"))
      render params[:id]
    else
      redirect_to root_path
    end
  end
end
