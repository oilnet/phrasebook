class MovePhrasesTextContentsToTranslations < ActiveRecord::Migration
  def up
    Phrase.all.each do |p|
      t = p.translations.create(
        text: p.text,
        recording_data: p.recording_data,
        language: p.language)
      # Make it approved while we're at it...
      p.approved = true
      p.save
    end
    # Destructive!
    ps=[]; Phrase.all.each {|p| ps << p if p.translations.count > 2}
    ps.each do |p|
      loop do
        puts "Phrase #{p.id}: removing #{p.translations.last.inspect}."
        p.translations.last.destroy
        break if p.translations.count == 2
      end
    end
    remove_column :phrases, :text, :text
    remove_column :phrases, :recording_data, :binary
    remove_column :phrases, :language, :string
  end

  def down
    add_column :phrases, :text, :text
    add_column :phrases, :recording_data, :binary
    add_column :phrases, :language, :string
    # Possibly incomplete or wrong and dangerous in any case. But who cares.
    Translation.where(language: 'de').all.each do |translation|
      translation.phrase.update_attribute(:text, translation.text)
      translation.phrase.update_attribute(:recording_data, translation.recording_data)
      translation.phrase.update_attribute(:language, translation.language)
      translation.destroy
    end
    Phrase.all.each {|p| p.update_attribute(:approved, false)}
  end
end
