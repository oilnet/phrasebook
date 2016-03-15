class Admin::PhrasesController < Admin::AdminController
  before_filter :find_objects
  
  def index
    # Siehe before_filter.
  end
  
  def new
    @phrase = Phrase.new
    # New Phrase needs two Translations, one for each language.
    t = []
    @supported_languages.each do |l|       
      t << @phrase.translations.build(language: l.language)
    end
    if params[:language] && params[:text]
      t.first.language = params[:language]
      t.first.text = params[:text]
    end
  end
  
  def show
    @phrase = Phrase.find params[:id]
    # Existing Phrase, even if it was incomplete before, needs
    # two Translations as well. The second should be of the
    # language that the first is not, if at all possible.
    sl = @supported_languages.map {|l| l.language}
    @phrase.translations.each {|t| sl.delete t.language}
    count = @phrase.translations.count
    sl.each {|l| @phrase.translations.build(language: l); count += 1}
    (2 - count).times {|t| @phrase.translations.build}
  end

  def create
    @phrase = Phrase.new(phrase_params)
    if @phrase.save
      @phrase.set_sort_value
      logger.debug "*** Phrase saved successfully."
      redirect_to [:admin, @phrase], notice: t('admin.phrases.created', default: 'Phrase created.')
    else
      logger.debug "*** Problem saving Phrase; rendering #new (#{@phrase.errors.inspect})"
      render action: 'new'
    end
  end
  
  def update
    if @phrase.update(phrase_params)
      @phrase.set_sort_value
      redirect_to [:admin, @phrase], notice: t('admin.phrases.updated', default: 'Phrase saved.')
    else
      flash[:alert] = t('admin.phrases.not_updated', default: 'Phrase could not be saved.')
      render action: 'show'
    end
  end

  # DELETE /phrases/1
  def destroy
    @phrase.destroy
    redirect_to admin_phrases_path, notice: t('admin.phrases.destroyed', default: 'Phrase deleted.')
  end
  
  private
  
  def find_objects
    @phrase = Phrase.find(params[:id]) if params[:id]
    @phrases = Phrase.includes(:translations)
    @supported_languages = SupportedLanguage.all
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def phrase_params
    p = params.require(:phrase).permit(
      :tags, :usefulness, :approved, :image_data, :image_data_delete, :image_source, :image_license,
      translations_attributes: [:id, :text, :transliteration, :language, :raw_recording_data])
    p[:image_data] = p[:image_data].read if p[:image_data] # It's been set to a Blob...
    return p
  end
end
