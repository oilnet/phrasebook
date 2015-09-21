# t.text     "text"
# t.string   "tags"
# t.string   "rec_filename"
# t.string   "rec_filetype"
# t.binary   "rec_contents"
# t.integer  "usefulness"
# t.datetime "created_at"
# t.datetime "updated_at"
    
class Phrase < ActiveRecord::Base
  validates :text, presence: true
  scope :untranslated, -> { where.not(id: Translation.select(:phrase_id).uniq) }
end
