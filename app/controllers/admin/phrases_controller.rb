class Admin::PhrasesController < Admin::AdminController
  before_filter :find_objects
  
  def index
    # Siehe before_filter.
  end
  
  def new
    @phrase = Phrase.new(approved: true)
    @supported_languages.each do |l|       
      @phrase.translations.build(language: l.name)
    end
  end
  
  def show
    @phrase = Phrase.find params[:id]
  end

  def create
    @phrase = Phrase.new(phrase_params)
    if @phrase.save
      redirect_to [:admin, @phrase], notice: 'Phrase angelegt.'
    else
      render :new
    end
  end
  
  def update
    if @phrase.update(phrase_params)
      redirect_to [:admin, @phrase], notice: 'Phrase gespeichert.'
    else
      flash[:alert] = 'Phrase konnte nicht gespeichert werden.'
      render action: 'show'
    end
  end

  # DELETE /phrases/1
  # DELETE /phrases/1.json
  def destroy
    @phrase.destroy
    redirect_to admin_phrases_path, notice: 'Phrase gelöscht.'
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
      :tags, :usefulness, :approved,
      :image_data, :image_source, :image_license,
      translations_attributes: [
        :id, :text, :transliteration, :language, :recording
    ])
    p[:image_data] = p[:image_data].read if p[:image_data]
    return p
  end
end
