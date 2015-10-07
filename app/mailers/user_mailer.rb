class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url  = "#{root_url}/users/#{user.activation_token}/activate"
    mail(to: user.email)
  end

  def activation_success_email(user)
    @user = user
    @url  = "#{root_url}/login"
    mail(to: user.email)
  end
end
