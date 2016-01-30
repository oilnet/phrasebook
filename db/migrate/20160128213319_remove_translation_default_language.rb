class RemoveTranslationDefaultLanguage < ActiveRecord::Migration
  def up
    change_column :translations, :language, :string, default: '', null: false
  end
  
  def down
    change_column :translations, :language, :string, default: 'ar', null: false
  end
end
