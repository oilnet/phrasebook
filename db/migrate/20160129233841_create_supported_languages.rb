class CreateSupportedLanguages < ActiveRecord::Migration
  def change
    create_table :supported_languages do |t|
      t.string :language, null: false
      t.string :name, null: false
    end
  end
end
