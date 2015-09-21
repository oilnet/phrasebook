class RenameTranslationsAttrs < ActiveRecord::Migration
  def change
    rename_column :translations, :lang, :language
    rename_column :translations, :country, :source_country
  end
end
