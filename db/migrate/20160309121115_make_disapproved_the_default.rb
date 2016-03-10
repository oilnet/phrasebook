class MakeDisapprovedTheDefault < ActiveRecord::Migration
  def change
    change_column :phrases, :approved, :boolean, default: false
  end
end
