class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.references :phrase, index: true, foreign_key: true
      t.text :original
      t.text :transliteration
      t.string :rec_filename
      t.string :rec_filetype
      t.binary :rec_contents
      t.string :lang
      t.string :country

      t.timestamps null: false
    end
  end
end
