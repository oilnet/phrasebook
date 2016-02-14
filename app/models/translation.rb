# == Schema Information
#
# Table name: translations
#
#  id              :integer          not null, primary key
#  phrase_id       :integer
#  text            :text
#  transliteration :text
#  recording_data  :binary
#  language        :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_translations_on_phrase_id  (phrase_id)
#

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

  validates :language, 
    presence: true, 
    uniqueness: {scope: :phrase, message: "Die Phrase hat bereits eine Übersetzung in der gewählten Sprache."}
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
        if recording_data[0,4] == 'data'
          logger.debug "*** Recording data seems to be fresh base64..."
          return if recording_data.blank? # It might just be the empty input...
          tempfile = Tempfile.new('recording_', :encoding => 'ascii-8bit')
          recording_data = Base64.decode64(recording_data.split(',').last)
          logger.debug "*** Decoded base64 string."
          tempfile.write recording_data
          logger.debug "*** Wrote #{tempfile.path}."
          # Do the conversion, but only if input is WAV.
          if recording_data[0,4] == 'RIFF'
            ffmpeg = FFMPEG::Movie.new(tempfile.path)
            mp3_file = "#{tempfile.path}.mp3"
            ffmpeg.transcode(mp3_file)
            self.recording_data = File.read(mp3_file)
            logger.debug "*** Converted to MP3."
            tempfile.close
            tempfile.unlink
            logger.debug "*** Deleted tempfile."
          end
        end
      rescue Exception => e
        logger.error e.inspect
        errors.add(:recording_data, "konnte wegen eines Fehlers bei der Umwandlung zu MP3 nicht gespeichert werden (#{e})") # TODO: i18n!
      end
    end
  end
end
