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
  default_scope {order('count DESC, GREATEST(created_at, updated_at) DESC, text ASC')}
  
  def self.add(search_string)
    if s = Search.find_by_text(search_string)
      s.count += 1
      s.save
    else
      Search.create(text: search_string)
    end
  end
  
  def most_recent_timestamp
    t = created_at
    t = updated_at if updated_at > created_at
    return t
  end
end
