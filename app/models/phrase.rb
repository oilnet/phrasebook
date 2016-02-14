# == Schema Information
#
# Table name: phrases
#
#  id            :integer          not null, primary key
#  tags          :string
#  usefulness    :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  approved      :boolean          default(FALSE)
#  image_data    :binary
#  image_source  :string
#  image_license :string
#

# t.text     "text"
# t.string   "tags"
# t.binary   "recording_data"
# t.integer  "usefulness"
# t.datetime "created_at"
# t.datetime "updated_at"
    
class Phrase < ActiveRecord::Base
  has_many :translations, dependent: :delete_all
  
  before_validation :ensure_image_data_deleted
  
  validates :usefulness, presence: true, numericality: {only_integer: true}
  validate :translation_text_presence
  
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

  # Only validate the text's presence if there is no other Translation
  # with a present text is attached to this Translation's Phrase (issue #38).
  def translation_text_presence
    present = false
    translations.each {|t| present = true if !t.text.blank?}
    unless present
      errors.add 'translations.text', "muss in mindestens einer Sprache vorhanden sein."
    end
  end
end
