class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.text :text
      t.string :tags
      t.string :rec_filename
      t.string :rec_filetype
      t.binary :rec_contents
      t.integer :usefulness

      t.timestamps null: false
    end
  end
end
