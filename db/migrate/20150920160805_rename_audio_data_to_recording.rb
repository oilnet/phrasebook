class RenameAudioDataToRecording < ActiveRecord::Migration
  def change
    rename_column :translations, :audio_data, :recording_data
  end
end
