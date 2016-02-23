# == Schema Information
#
# Table name: translations
#
#  id              :integer          not null, primary key
#  phrase_id       :integer
#  text            :text
#  transliteration :text
#  recording_data  :binary
#  language        :string           default("ar"), not null
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

require 'fileutils'

class Translation < ActiveRecord::Base
  belongs_to :phrase

  attr_accessor :raw_recording_data
  
  validates :language, 
    presence: true, 
    uniqueness: {scope: :phrase, message: "Die Phrase hat bereits eine Übersetzung in der gewählten Sprache."} # TODO: i18n: العبارة موجودة مسبقا باللغة المختارة
  
  default_scope {order(language: :asc)}
  scope :language, ->(language) {where("language = ?", language)}
 
  def recording_filename
    "#{Rails.application.class.parent_name.downcase}-phrase_#{phrase_id}-translation_#{id}-#{language}.mp3"
  end
  
  def human_readable_language
    FbLanguage.find(language)
  end

  def raw_recording_data=(base64)
    if base64.blank?
      logger.debug "*** No new recording for Translation##{id}."
    else
      logger.debug "*** Translation##{id}: new raw_recording_data (#{base64[0,21]})."
      recording_data_will_change!
      begin
        binary = Base64.decode64(base64.split(',').last)
        logger.debug "*** Decoded base64 string."
        if binary && binary[0,4] == 'RIFF' # Do the conversion, but only if input is WAV.
          wav_file = "tmp/recordings/#{id}.wav"
          mp3_file = wav_file.gsub(/\.wav/, '.mp3')
          FileUtils.mkdir_p 'tmp/recordings'
          File.open(wav_file, 'wb') do |file|
            file.write binary
            logger.debug "*** Wrote #{wav_file}."
            ffmpeg = FFMPEG::Movie.new(file.path)
            ffmpeg.transcode(mp3_file)
            logger.debug "*** Wrote #{mp3_file}"
            # TODO: Figure out why in the world simply /setting/ the attributes
            # doesn't work. Really, really shouldn't have to use update_attributes
            # here ... even with protection from an endless loop I'm not sure whether
            # it is safe.
            self.update_attributes(recording_data: File.read(mp3_file))
            logger.debug "*** Saved recording_data on Translation##{id}."
          end
        else
          raise 'Browser hat keine Audiodaten geschickt' # TODO: i18n: لم يرسل المتصفح بيانات صوتية
        end
      rescue Exception => e
        logger.error e.inspect
        errors.add(:recording_data, "konnte wegen eines Fehlers bei der Umwandlung zu MP3 nicht gespeichert werden (#{e})")
        # TODO: i18n: لم يمكن حفظه بسبب خطأ في تحويل صيغته
      end
    end
  end
end
