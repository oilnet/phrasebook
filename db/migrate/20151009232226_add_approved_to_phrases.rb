class AddApprovedToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :approved, :boolean, default: false
  end
end
