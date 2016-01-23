class Admin::PhrasesController < Admin::AdminController
  before_filter :find_phrases
  def index
  end
  
  def show
    @phrase = Phrase.find params[:id]
  end
  
  private
  
  def find_phrases
    @phrases = Phrase.all
  end
end
