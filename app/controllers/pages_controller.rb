class PagesController < ApplicationController
  def index
    redirect_to action: :show, id: :welcome
  end

  def show
    render params[:id]
  end
end
