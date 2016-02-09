# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  text       :string
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Search < ActiveRecord::Base
end
