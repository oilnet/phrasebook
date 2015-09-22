class RepeatTranslationsChangesInPhrases < ActiveRecord::Migration
  def change
    rename_column :phrases, :rec_contents, :recording_data
    remove_column :phrases, :rec_filename
    remove_column :phrases, :rec_filetype
  end
end
