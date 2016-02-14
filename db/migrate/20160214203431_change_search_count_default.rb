class ChangeSearchCountDefault < ActiveRecord::Migration
  def change
    change_column :searches, :count, :integer, null: false, default: 1
  end
end
