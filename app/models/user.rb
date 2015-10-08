class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: {minimum: 8}, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }
  validates :email, uniqueness: true, email_format: {message: I18n.t('models.user.has_invalid_format')}
  
  def is_admin?
    false # TODO: Füll mich aus!
  end
end
