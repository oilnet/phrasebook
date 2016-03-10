class AddSortValueToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :sort_value, :string, null: false, default: ''
    Phrase.all.each do |p|
      p.sort_value = p.main_translation.text.gsub(/(\(.*?\))( |)/, '').downcase
      p.save
    end
    change_column :phrases, :sort_value, :string, null: false, default: nil
  end
end
