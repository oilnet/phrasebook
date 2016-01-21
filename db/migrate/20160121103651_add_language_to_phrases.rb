class AddLanguageToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :language, :string, default: 'de', null: false
  end
end
