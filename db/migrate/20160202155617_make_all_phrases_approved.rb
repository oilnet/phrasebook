class MakeAllPhrasesApproved < ActiveRecord::Migration
  def up
    Phrase.all.each {|p| p.update_attribute(:approved, true)}
  end

  # Dangerous, as always...
  def down
    Phrase.all.each {|p| p.update_attribute(:approved, false)}
  end
end
