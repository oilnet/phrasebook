# t.text     "text"
# t.string   "tags"
# t.binary   "recording_data"
# t.integer  "usefulness"
# t.datetime "created_at"
# t.datetime "updated_at"
    
class Phrase < ActiveRecord::Base
  scope :approved, -> {where(approved: true)}
  scope :useful, -> {where('usefulness > ?', 0)}
  scope :tag_field, ->(tags) {tags ? where('tags LIKE ?', "%#{tags}%") : all}
  default_scope {includes(:translations).order('translations.text ASC')}
  has_many :translations, dependent: :delete_all
  # validates :translations, presence: true
  accepts_nested_attributes_for :translations, allow_destroy: true
  before_save :normalize_tags
  attr_accessor :recording

  def main_translation(lang = :de)
    translations.language(lang).first || Translation.new(
      text: "Keine deutsche Übersetzung eingetragen.", language: :de)
  end
  
  def secondary_translation(lang = :ar)
    translations.where(language: lang).first || Translation.new
  end
  
  def self.search(search)
    s = "%#{search.downcase}%"
    includes(:translations).where('(LOWER(translations.text) LIKE ?) OR (LOWER(phrases.tags) LIKE ?)', s, s)
  end
  
  private

  def normalize_tags
    tags.downcase!
  end
end
