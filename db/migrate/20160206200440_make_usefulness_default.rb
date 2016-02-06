class MakeUsefulnessDefault < ActiveRecord::Migration
  def change
    change_column :phrases, :usefulness, :integer, null: false, default: 0
  end
end
