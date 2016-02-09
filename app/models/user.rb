# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string
#  salt                            :string
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  activation_state                :string
#  activation_token                :string
#  activation_token_expires_at     :datetime
#  name                            :string
#  admin                           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # validates :password, length: {minimum: 8}, if: -> { new_record? || changes["password"] }
  # validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  # validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }
  # validates :email, uniqueness: true, email_format: {message: I18n.t('models.user.has_invalid_format')}
end
