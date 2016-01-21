class RepeatTranslationsChangesInPhrases < ActiveRecord::Migration
  def change
    rename_column :phrases, :rec_contents, :recording_data
    remove_column :phrases, :rec_filename, :string
    remove_column :phrases, :rec_filetype, :string
  end
end
