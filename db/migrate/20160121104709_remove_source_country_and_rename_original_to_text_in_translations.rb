class RemoveSourceCountryAndRenameOriginalToTextInTranslations < ActiveRecord::Migration
  def change
    remove_column :translations, :source_country
    rename_column :translations, :original, :text
  end
end
