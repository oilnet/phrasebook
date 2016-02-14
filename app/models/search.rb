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
  def self.add(search_string)
    if s = Search.find_by_text(search_string)
      s.count += 1
      s.save
    else
      Search.create(text: search_string)
    end
  end
end
