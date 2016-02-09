class PhrasesController < ApplicationController
  before_action :set_phrase, only: [:show, :edit, :update, :destroy]
  skip_filter :require_login, only: [:index, :show, :new, :create]

  # GET /phrases
  def index
    if params[:search] && !params[:search].empty?
      @phrases = Phrase.search(params[:search])
    else
      @phrases = Phrase.all.approved.useful.tag_field(params[:tags])
    end
  end

  # GET /phrases/1.jpg
  def show
    respond_to do |format|
      format.jpg {send_data(@phrase.image_data, type: 'image/jpeg', filename: "#{@phrase.id}.jpg", disposition: 'inline')}
    end
  end
  
  private
  
  def set_phrase
    @phrase = Phrase.find(params[:id])
  end
end
