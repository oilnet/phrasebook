# == Schema Information
#
# Table name: supported_languages
#
#  id       :integer          not null, primary key
#  language :string           not null
#  name     :string           not null
#

class SupportedLanguage < ActiveRecord::Base
  has_many :translations
end
