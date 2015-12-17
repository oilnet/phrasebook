class PhrasesController < ApplicationController
  before_action :set_phrase, only: [:show, :edit, :update, :destroy]
  before_filter :set_languages, only: [:index, :show, :new, :create] # So?
  before_filter :only_admins, except: [:index, :show, :new, :create]
  skip_filter :require_login, only: [:index, :show, :new, :create]

  # GET /phrases
  # GET /phrases.json
  def index
    if admin?
      @phrases = Phrase.tags(params[:tags]).paginate(page: params[:page], per_page: 10)
    else
      @phrases = Phrase.approved.tags(params[:tags]).paginate(page: params[:page], per_page: 10)
    end
  end
  
  # GET /phrases/1.ogg
  def show
    respond_to do |format|
      format.ogg { send_data(
        @phrase.recording_data, 
        type: :ogg, 
        filename: @phrase.recording_filename
      )}
    end
  end

  # GET /phrases/new
  def new
    @phrase = Phrase.new
  end

  # GET /phrases/1/edit
  def edit
    admin? || redirect_to(phrases_path) # TODO: Nicht für die Ewigkeit!
  end

  # POST /phrases
  # POST /phrases.json
  def create
    @phrase = Phrase.new(phrase_params)
    if @phrase.save
      redirect_to_next_screen
    else
      render :new
    end
  end

  # PATCH/PUT /phrases/1
  # PATCH/PUT /phrases/1.json
  def update
    admin? || redirect_to(phrases_path) # TODO: Nicht für die Ewigkeit!
    if @phrase.update(phrase_params)
      redirect_to_next_screen
    else
      render :edit
    end
  end

  # DELETE /phrases/1
  # DELETE /phrases/1.json
  def destroy
    admin? || redirect_to(phrases_path) # TODO: Nicht für die Ewigkeit!
    @phrase.destroy
    redirect_to phrases_path, notice: 'Phrase gelöscht.'
  end

  private  
  
  def redirect_to_next_screen
    message = 'Vorschlag gespeichert!'
    case params[:commit].keys.first.to_sym
      when :new_translation
        new_params = {translation: {
          phrase_id: @phrase.id}}
        redirect_to new_translation_path(new_params), notice: message
      when :new_phrase
        new_params = {translation: {
          tags: phrase_params[:tags]}}
        redirect_to new_phrase_path(new_params), notice: message
      when :show_list
        redirect_to phrases_path, notice: message
      else
        render :edit
    end
  end

  def set_phrase
    begin
      id = params[:id].split('.ogg').first
      @phrase = Phrase.find(id)
    rescue
      # FIXME: Macht Audios abspielen kaputt!
      redirect_to phrases_path(tags: params[:id])
    end
  end
  
  def set_languages
    @languages = Translation.all.collect {|t| t.language}.uniq
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def phrase_params
    params.require(:phrase).permit(:text, :tags, :recording, :usefulness, :approved)
  end
  
  def only_admins
    unless admin?
      redirect_to root_path
    end
  end
end
