class CreateSupportedLanguages < ActiveRecord::Migration
  def up
    create_table :supported_languages do |t|
      t.string :language, null: false
      t.string :name, null: false
    end
    puts "You might want to run rake db:seed now."
  end

  def down
    drop_table :supported_languages
  end
end
