class TranslationsController < ApplicationController
  before_action :set_translation, only: [:show, :edit, :update, :destroy]
=begin
  before_action :set_phrases, only: [:new, :edit, :create, :update]
  before_action :set_languages, only: [:new, :edit, :create, :update]
  before_action :set_countries, only: [:new, :edit, :create, :update]
=end
  skip_filter :require_login, only: [:index, :show, :new, :create]

=begin
  # GET /translations
  # GET /translations.json
  def index
    @translations = Translation.all
  end
=end

  # GET /translations/1.mp3
  def show
    respond_to do |format|
      format.mp3 { send_data(
        @translation.recording_data, 
        type: :mp3, 
        filename: @translation.recording_filename
      )}
    end
  end

=begin
  # GET /translations/new
  def new
    @translation = Translation.new
  end

  # GET /translations/1/edit
  def edit
  end

  # POST /translations
  # POST /translations.json
  def create
    @translation = Translation.new(translation_params)
    if @translation.save
      redirect_to_next_screen
    else
      render :new
    end
  end

  # PATCH/PUT /translations/1
  # PATCH/PUT /translations/1.json
  def update
    if @translation.update(translation_params)
      redirect_to_next_screen
    else
      render :edit
    end
  end

  # DELETE /translations/1
  # DELETE /translations/1.json
  def destroy
    @translation.destroy
    redirect_to phrases_path, notice: 'Übersetzung gelöscht.'
  end
=end

  private

  def set_translation
    @translation = Translation.find(params[:id])
  end

=begin  
  def set_phrases
    @phrases = Phrase.all.map {|f| ["#{f.text} (#{f.tags})", f.id]}
  end
  
  def set_languages
    @languages = FbLanguage.all.map {|l| [l.name, l.code]}
  end
  
  def set_countries
    @countries = FbCountry.all.map {|c| [c.name, c.code]}
  end
  
  def redirect_to_next_screen
    message = 'Übersetzung hinzugefügt'
    begin
      case params[:commit].keys.first.to_sym
        when :new_translation then new_params = {translation: {
          phrase_id: translation_params[:phrase_id]}}
          redirect_to new_translation_path(new_params), notice: message
        when :new_phrase then new_params = {translation: {
          language: translation_params[:language], 
          source_country: translation_params[:source_country]}}
          redirect_to new_phrase_path(new_params), notice: message
        when :next_untranslated_phrase then new_params = {translation: {
          language: translation_params[:language], 
          source_country: translation_params[:source_country], 
          phrase_id: Phrase.untranslated.first.id}}
          redirect_to new_translation_path(new_params), notice: message
        when :show_list
          redirect_to phrases_path
        else
          render :edit
      end
    rescue
      flash[:notice] = 'Keine unübersetzten Phrasen mehr übrig.'
      render :new
    end
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def translation_params
    params.require(:translation).permit(:phrase_id, :original, :transliteration, :recording, :language, :source_country)
  end
=end
end
