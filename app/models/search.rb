# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  text       :string
#  count      :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Search < ActiveRecord::Base  
  default_scope {
    order(yields_results: :asc).order(count: :desc).order('GREATEST(created_at, updated_at) DESC').order(text: :asc)
  }
  
  def self.add(search_string, result_count)
    s = Search.find_by_text(search_string) || Search.new
    s.yields_results = (result_count > 0)
    if s.new_record?
      s.text = search_string
    else
      s.count += 1
    end
    s.save
  end
  
  def most_recent_timestamp
    t = created_at
    t = updated_at if updated_at > created_at
    return t
  end
end
