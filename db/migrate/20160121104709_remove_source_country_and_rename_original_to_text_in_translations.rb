class RemoveSourceCountryAndRenameOriginalToTextInTranslations < ActiveRecord::Migration
  def change
    remove_column :translations, :source_country, :string
    rename_column :translations, :original, :text
  end
end
