class AddYieldsResultsToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :yields_results, :boolean, nil: false, default: false
  end
end
