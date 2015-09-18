class FbLanguage
  include ActiveModel::Model
  attr_accessor :name, :code
  
  def self.all
    fb_langs = []
    LanguageList::ISO_639_1.each do |l|
      fbl = FbCountry.new
      fbl.name = l.name
      fbl.code = l.iso_639_1
      fb_langs << fbl
    end
    fb_langs
  end
end
