class AddImageDataToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :image_data, :binary
  end
end
