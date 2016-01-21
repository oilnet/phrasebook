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
  validates :text, presence: true
  validates :language, presence: true
  before_save :extract_recording_data
  attr_accessor :recording
 
  def recording_filename
    f  = "#{Rails.application.class.parent_name.downcase}-phrase_#{phrase_id}-translation_#{id}-#{language}"
    f += ".ogg"
    f
  end
  
  def human_readable_language
    FbLanguage.find(language)
  end
  
  private
  
  # TODO: Make me DRY!!!
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
        unknown_type_file = FFMPEG::Movie.new(tempfile.path)
        ogg_file = "#{tempfile.path}.ogg"
        unknown_type_file.transcode(ogg_file)
        self.recording_data = File.read(ogg_file)
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
