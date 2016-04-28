class Tag
  include ActiveModel::Model

  def self.all
    Phrase.all.map {|p| p.tags}
  end
end
