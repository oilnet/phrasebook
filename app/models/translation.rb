# t.integer  "phrase_id"
# t.text     "original"
# t.text     "transliteration"
# t.binary   "recording_data"
# t.string   "language"
# t.string   "source_country"
# t.datetime "created_at"
# t.datetime "updated_at"

class Translation < ActiveRecord::Base
  belongs_to :phrase
  validates :phrase, presence: true
  validates :original, presence: true
  validates :language, presence: true
  before_save :extract_recording_data
  attr_accessor :recording
 
  def recording_filename
    f  = "#{Rails.application.class.parent_name.downcase}-phrase_#{phrase_id}-translation_#{id}-#{language}"
    f += "_#{source_country}" unless source_country.blank?
    f += ".ogg"
    f
  end 
  
  private
  
  def extract_recording_data
    logger.warn "*** #{recording.inspect}"
    if recording
      unknown_file = FFMPEG::Movie.new recording.tempfile.path
      ogg_file = "#{recording.tempfile}.ogg"
      unknown_file.transcode(ogg_file)
      self.recording_data = File.read(ogg_file)
    end
  end
end
