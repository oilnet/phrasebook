class RemoveThirdTranslationFromAllAffectedPhrases < ActiveRecord::Migration
  # Destructive!
  def up
    ps=[]; Phrase.all.each {|p| ps << p if p.translations.count > 2}
    ps.each do |p|
      loop do
        puts "Phrase #{p.id}: removing #{p.translations.last.inspect}."
        p.translations.last.destroy
        break if p.translations.count == 2
      end
    end
  end
end
