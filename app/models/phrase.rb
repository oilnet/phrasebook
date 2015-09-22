# t.text     "text"
# t.string   "tags"
# t.binary   "recording_data"
# t.integer  "usefulness"
# t.datetime "created_at"
# t.datetime "updated_at"
    
class Phrase < ActiveRecord::Base
  validates :text, presence: true
  scope :untranslated, -> {where.not(id: Translation.select(:phrase_id).uniq)}
  has_many :translations
  before_save :extract_recording_data
  attr_accessor :recording
 
  def recording_filename
    "#{Rails.application.class.parent_name.downcase}-phrase_#{id}.ogg"
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
        msg = "#{Time.now}: an error occured in Phrase/extract_recording_data (#{e.inspect})"
        logger.error msg
        raise msg
      end
    end
  end
end
