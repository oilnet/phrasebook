class TranslationsController < ApplicationController
  before_action :set_translation, only: [:show, :edit, :update, :destroy]
  before_action :set_phrases, only: [:new, :edit, :create, :update]
  before_action :set_languages, only: [:new, :edit, :create, :update]
  before_action :set_countries, only: [:new, :edit, :create, :update]

  # GET /translations
  # GET /translations.json
  def index
    @translations = Translation.all
  end

  # GET /translations/1.ogg
  def show
    respond_to do |format|
      format.ogg { send_data(
        @translation.recording_data, 
        type: :ogg, 
        filename: @translation.recording_filename
      )}
    end
  end

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
    redirect_to phrases_path, notice: 'Translation was successfully destroyed.'
  end

  private

  def set_translation
    @translation = Translation.find(params[:id])
  end
  
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
    message = 'Translation was successfully created.'
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
        else
          render :edit
      end
    rescue
      flash[:notice] = 'No untranslated phrases are left. You can add a new translation or choose to do something else.'
      render :new
    end
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def translation_params
    params.require(:translation).permit(:phrase_id, :original, :transliteration, :recording, :language, :source_country)
  end
end
