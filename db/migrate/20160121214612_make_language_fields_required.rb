class MakeLanguageFieldsRequired < ActiveRecord::Migration
  def up
    change_column :phrases, :language, :string, default: 'de', null: false
    change_column :translations, :language, :string, default: 'ar', null: false
  end

  def down
    change_column :phrases, :language, :string, null: true 
    change_column :translations, :language, :string, null: true 
  end
end
