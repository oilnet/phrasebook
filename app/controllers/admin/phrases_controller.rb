class Admin::PhrasesController < Admin::AdminController
  before_filter :find_objects
  
  def index
    # Siehe before_filter.
  end
  
  def new
    @phrase = Phrase.new(approved: true)
    # New Phrase needs two Translations, one for each language.
    @supported_languages.each do |l|       
      @phrase.translations.build(language: l.language)
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
      logger.debug "*** Phrase saved successfully."
      redirect_to [:admin, @phrase], notice: 'Phrase angelegt.' # TODO: i18n: تم حفظ العبارة الجديدة
    else
      logger.debug "*** Problem saving Phrase; rendering #new (#{@phrase.errors.inspect})"
      render action: 'new'
    end
  end
  
  def update
    if @phrase.update(phrase_params)
      redirect_to [:admin, @phrase], notice: 'Phrase gespeichert.' # TODO: i18n: تم حفظ التغييرات
    else
      flash[:alert] = 'Phrase konnte nicht gespeichert werden.' # TODO: i18n: ليس بالإمكان حفظ العبارة
      render action: 'show'
    end
  end

  # DELETE /phrases/1
  # DELETE /phrases/1.json
  def destroy
    @phrase.destroy
    redirect_to admin_phrases_path, notice: 'Phrase gelöscht.' # TODO: i18n: تم حذف العبارة
  end
  
  private
  
  def find_objects
    @phrase = Phrase.find(params[:id]) if params[:id]
    @phrases = Phrase.all
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
