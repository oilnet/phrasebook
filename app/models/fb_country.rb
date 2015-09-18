class FbCountry
  include ActiveModel::Model
  attr_accessor :name, :code
  
  def self.all
    fb_countries = []
    Country.all.each do |c|
      fbc = FbCountry.new
      fbc.name = c.translation(I18n.locale.to_s)
      fbc.code = c.alpha2.downcase.to_sym
      fb_countries << fbc
    end
    fb_countries
  end
end
