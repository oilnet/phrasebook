class ChangeTranslationRecordingColumns < ActiveRecord::Migration
  def change
    rename_column :translations, :rec_contents, :audio_data
    remove_column :translations, :rec_filename, :string
    remove_column :translations, :rec_filetype, :string
  end
end
