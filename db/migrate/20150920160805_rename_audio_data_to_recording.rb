class RenameAudioDataToRecording < ActiveRecord::Migration
  def change
    rename_column :translations, :audio_data, :recording_data
    remove_column :translations, :rec_filename, :string
  end
end
