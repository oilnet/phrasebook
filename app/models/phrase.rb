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
#  sort_value    :string           default(""), not null
#

# t.text     "text"
# t.string   "tags"
# t.binary   "recording_data"
# t.integer  "usefulness"
# t.datetime "created_at"
# t.datetime "updated_at"
    
class Phrase < ActiveRecord::Base
  before_validation :ensure_image_data_deleted
  before_save :normalize_tags
  
  has_many :translations, dependent: :delete_all
  accepts_nested_attributes_for :translations, allow_destroy: true
  
  validates :usefulness, presence: true, numericality: {only_integer: true}
  validate :translation_text_presence
  
  default_scope {order(sort_value: :asc, approved: :asc)}
  scope :approved, -> {where(approved: true)}
  scope :useful, -> {where('usefulness > ?', 0)}
  # http://www.postgresql.org/docs/9.3/static/functions-matching.html - for MySQL it would be REGEXP.
  scope :tag_field, ->(tags) {where('tags SIMILAR TO ?', "%(#{tags.gsub(/, ?/, '|')})%")}
  
  attr_accessor :image_data_delete

  def main_translation(lang = :de)
    t = translations.language(lang).first 
    if t.nil? || t.text.blank?
      t = translations.not_blank.first || Translation.new(
        text: I18n.t('phrase.no_such_translation',
        default: 'No translation available'),
        language: lang
      )
    end; return t
  end
  
  def secondary_translation(lang = :ar)
    translations.where(language: lang).first || Translation.new
  end
  
  def self.search(search)
    # TODO: Nicht die Nadel, sondern den Heuhaufen verändern! An die SQL-Abfrage dran! Siehe ankidict...
    s = search.downcase.gsub(/[أإ ّ َ ً ُ ٌ ِ ٍ ْآـلألآة]/, '')
    s = "%#{s}%"
    joins(:translations).where('LOWER(translations.text) LIKE ?', s)
  end

  def self.with_tag(tag)
    s = "%#{tag.downcase}%"
    where('LOWER(tags) LIKE ?', s)
  end
  
  def increase_usefulness
    self.update_attribute(:usefulness, usefulness+1)
    logger.debug "*** Usefulness for Phrase##{id} increased to #{usefulness}."
  end
  
  def set_sort_value
    unless main_translation.text.blank?
      self.update_attribute(
        :sort_value,
        main_translation.text.gsub(/(\(.*?\))( |)/, '').downcase
      )
    end
  end
  
  private

  def normalize_tags
    tags.downcase!
  end
  
  def ensure_image_data_deleted
    if image_data_delete.to_i == 1 && image_data != nil
      logger.debug "*** Removing image and associated data."
      self.image_data = nil
      self.image_source = nil
      self.image_license = nil
    end
  end

  # Only validate the text's presence if there is no other Translation
  # with a present text is attached to this Translation's Phrase (issue #38).
  def translation_text_presence
    present = false
    translations.each {|t| present = true if !t.text.blank?}
    unless present
      errors.add 'translations.text', I18n.t(
        'models.phrase.attributes.translations.min_amount',
        default: 'needs at least one translation'
      )
    end
  end
end
