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
  # validates :phrase, presence: true
  # validates :text, presence: true
  # validates :language, presence: true
  before_save :extract_recording_data
  attr_accessor :recording
  default_scope {order(text: :asc)}
  scope :language, ->(language) {where("language = ?", language)}
  validates :text, presence: true
  validates :language, presence: true, uniqueness: {scope: :phrase, message: "Die Phrase hat bereits eine Übersetzung in der gewählten Sprache."}
 
  def recording_filename
    f  = "#{Rails.application.class.parent_name.downcase}-phrase_#{phrase_id}-translation_#{id}-#{language}"
    f += ".mp3"
    f
  end
  
  def human_readable_language
    FbLanguage.find(language)
  end
  
  private
  
  def extract_recording_data
    if recording
      begin
        # If getUserData was used to record the audio, the
        # data will have been written into a hidden input.
        if recording.class == String
          return if recording.blank? # It might just be the empty input…
          tempfile = Tempfile.new('recording_', :encoding => 'ascii-8bit')
          tempfile.write Base64.decode64(recording.split(',').last)
          logger.info "*** Wrote #{tempfile.path}"
        # If neither getUserData nor Flash/Silverlight were
        # available, a simple file upload input was used.
        else
          tempfile = recording.tempfile
        end
        ffmpeg = FFMPEG::Movie.new(tempfile.path)
        mp3_file = "#{tempfile.path}.mp3"
        ffmpeg.transcode(mp3_file)
        self.recording_data = File.read(mp3_file)
        tempfile.close
        tempfile.unlink
      rescue e
        msg = "#{Time.now}: an error occured in Translation/extract_recording_data (#{e.inspect})"
        logger.error msg
        raise msg
      end
    end
  end
end
