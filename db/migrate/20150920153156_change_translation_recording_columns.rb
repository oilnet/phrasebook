class ChangeTranslationRecordingColumns < ActiveRecord::Migration
  def change
    rename_column :translations, :rec_contents, :audio_data
    remove_column :translations, :rec_filename
    remove_column :translations, :rec_filetype
  end
end
