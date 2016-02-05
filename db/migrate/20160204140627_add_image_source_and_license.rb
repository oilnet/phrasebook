class AddImageSourceAndLicense < ActiveRecord::Migration
  def change
    add_column :phrases, :image_source, :string
    add_column :phrases, :image_license, :string
  end
end
