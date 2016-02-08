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
  
  # validates :phrase_id, presence: true # TODO: Figure out why it fires even when Translation is attached to Phrase.
  validates :text, presence: true
  validates :language, presence: true, uniqueness: {scope: :phrase, message: "Die Phrase hat bereits eine Übersetzung in der gewählten Sprache."}, length: {is: 2}, format: {with: /[a-z][a-z]/}
  validate  :recording_data_is_mp3
  
  default_scope {order(text: :asc)}
  scope :language, ->(language) {where("language = ?", language)}
 
  def recording_filename
    f  = "#{Rails.application.class.parent_name.downcase}-phrase_#{phrase_id}-translation_#{id}-#{language}"
    f += ".mp3"
    f
  end
  
  def human_readable_language
    FbLanguage.find(language)
  end

  private
  
  def recording_data_is_mp3
    if recording_data
      begin
        # If getUserData was used to record the audio, the
        # data will have been written into a hidden input.
        if recording_data.class == String
          logger.debug "*** Recording data seems to be fresh base64..."
          return if recording_data.blank? # It might just be the empty input...
          tempfile = Tempfile.new('recording_', :encoding => 'ascii-8bit')
          tempfile.write Base64.decode64(recording_data.split(',').last)
          logger.debug "*** Wrote #{tempfile.path}."
        # If neither getUserData nor Flash/Silverlight were
        # available, a simple file upload input might have
        # been used.
        else
          tempfile = recording_data.tempfile
        end
        # Do the conversion...
        ffmpeg = FFMPEG::Movie.new(tempfile.path)
        mp3_file = "#{tempfile.path}.mp3"
        ffmpeg.transcode(mp3_file)
        self.recording_data = File.read(mp3_file)
        tempfile.close
        tempfile.unlink
        logger.debug "*** Converted to MP3 and deleted tempfile."
      rescue Exception => e
        logger.error e.inspect
        errors.add(:recording_data, "konnte wegen eines Fehlers bei der Umwandlung zu MP3 nicht gespeichert werden") # TODO: i18n!
      end
    end
  end
end
