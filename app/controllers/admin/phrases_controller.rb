class Admin::PhrasesController < Admin::AdminController
  before_filter :assign_instance_variables
  
  def index
  end
  
  def new
    @phrase = Phrase.new
    [:de, :ar].each {|l| @phrase.translations.build(language: l)}
  end
  
  def show
    @phrase = Phrase.find params[:id]
    respond_to do |format|
      format.html {}
      format.jpg {send_data(@phrase.image_data, type: 'image/jpeg', filename: "#{@phrase.id}.jpg", disposition: 'inline')}
    end
  end
  
  def update
    @phrase = Phrase.find params[:id]
    respond_to do |format|
      if @phrase.update(phrase_params)
        format.html {redirect_to [:admin, @phrase], notice: 'Phrase gespeichert.'}
        format.js {}
        format.json {render json: [:admin, @phrase], status: :updated, location: @phrase}
      else
        format.html {render action: 'show'}
        format.json {render json: @phrase.errors, status: :unprocessable_entity}
      end
    end
  end
  
  private
  
  def assign_instance_variables
    @phrases = Phrase.all
    @supported_languages = SupportedLanguage.all.map {|l| [l.name, l.language]}
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def phrase_params
    p = params.require(:phrase).permit(:text, :tags, :recording, :usefulness, :approved, :image_data)
    p[:image_data] = p[:image_data].read
    p
  end
end
