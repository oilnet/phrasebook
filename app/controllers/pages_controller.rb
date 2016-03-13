class PagesController < ApplicationController
  skip_filter :require_login

  # GET /pages
  def index
    redirect_to root_path
  end

  # GET /phrases/id, where id is app/views/pages/$id.$lang.html.haml
  def show
    page = File.join('app', 'views', 'pages', "#{params[:id]}.#{I18n.locale}.html.haml")
    if File.exist?(page)
      render params[:id]
    else
      redirect_to root_path
    end
  end
end
