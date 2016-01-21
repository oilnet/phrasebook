class MovePhrasesTextContentsToTranslations < ActiveRecord::Migration
  def up
    Phrase.all.each do |phrase|
      Translation.create(
        phrase: phrase,
        text: phrase.text,
        recording_data: phrase.recording_data,
        language: phrase.language
      )
    end
    remove_column :phrases, :text, :text
    remove_column :phrases, :recording_data, :binary
    remove_column :phrases, :language, :string
  end

  def down
    add_column :phrases, :text, :text
    add_column :phrases, :recording_data, :binary
    add_column :phrases, :language, :string
    # Possibly incomplete or wrong and dangerous in any case!
    Translation.where(language: 'de').all.each do |translation|
      translation.phrase.update_attribute(:text, translation.text)
      translation.phrase.update_attribute(:recording_data, translation.recording_data)
      translation.phrase.update_attribute(:language, translation.language)
      translation.destroy
    end
  end
end
