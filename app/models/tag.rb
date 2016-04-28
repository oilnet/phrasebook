class Tag
  include ActiveModel::Model

  def self.all
    Phrase.all.map {|p| p.tags.split}.flatten.uniq
  end
end
