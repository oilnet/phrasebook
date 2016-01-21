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
  end

  def change
    remove_column :phrases, :text, :text
    remove_column :phrases, :recording_data, :binary
    remove_column :phrases, :language, :string
  end
end
