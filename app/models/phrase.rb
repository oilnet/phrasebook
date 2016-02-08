# t.text     "text"
# t.string   "tags"
# t.binary   "recording_data"
# t.integer  "usefulness"
# t.datetime "created_at"
# t.datetime "updated_at"
    
class Phrase < ActiveRecord::Base
  has_many :translations, dependent: :delete_all
  
  before_validation :ensure_image_data_deleted
  
  # validate :number_of_translations # TODO: Find out why it fires even when number of Translations is exactly 2.
  validates :usefulness, presence: true, numericality: {only_integer: true}
  accepts_nested_attributes_for :translations, allow_destroy: true
  before_save :normalize_tags
  
  default_scope {includes(:translations).order('translations.text ASC')}
  scope :approved, -> {where(approved: true)}
  scope :useful, -> {where('usefulness > ?', 0)}
  scope :tag_field, ->(tags) {tags ? where('tags LIKE ?', "%#{tags}%") : all}
  
  attr_accessor :image_data_delete

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
  
  def ensure_image_data_deleted
    if image_data_delete.to_i == 1 && image_data != nil
      logger.debug "*** Removing image and associated data."
      # TODO: Figure out why in the world simply /setting/ the attributes
      # doesn't work. Really, really shouldn't have to use update_attributes
      # here ... even with protection from an endless loop I'm not sure whether
      # it is safe.
      self.update_attributes(
        image_data: nil,
        image_source: nil,
        image_license: nil
      )
    end
  end
  
=begin
  def number_of_translations
    if translations.count != 2
      errors.add :translations, "Jede Phrase benötigt genau zwei Übersetzungen." # TODO: i18n!
    end
  end
=end
end
