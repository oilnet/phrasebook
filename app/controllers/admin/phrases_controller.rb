class Admin::PhrasesController < Admin::AdminController
  def index
    @phrases = Phrase.all
  end
end
