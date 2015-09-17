class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :text
      t.integer :count

      t.timestamps null: false
    end
  end
end
