class PhrasesController < ApplicationController
  before_action :set_phrase, only: [:show, :edit, :update, :destroy]

  # GET /phrases
  # GET /phrases.json
  def index
    @phrases = Phrase.all
  end

  # GET /phrases/new
  def new
    @phrase = Phrase.new
  end

  # GET /phrases/1/edit
  def edit
  end

  # POST /phrases
  # POST /phrases.json
  def create
    @phrase = Phrase.new(phrase_params)
    if @phrase.save
      redirect_to phrases_url, notice: 'Phrase was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /phrases/1
  # PATCH/PUT /phrases/1.json
  def update
    if @phrase.update(phrase_params)
      redirect_to({action: :index}, notice: 'Phrase was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /phrases/1
  # DELETE /phrases/1.json
  def destroy
    @phrase.destroy
    redirect_to phrases_url, notice: 'Phrase was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phrase
      @phrase = Phrase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phrase_params
      params.require(:phrase).permit(:text, :tags, :rec_filename, :rec_filetype, :rec_contents, :usefulness)
    end
end
