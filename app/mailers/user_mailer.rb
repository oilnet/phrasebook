def join(*args)
  args.map { |arg| arg.gsub(%r{^/*(.*?)/*$}, '\1') }.join("/")
end

class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url  = join(root_url, I18n.locale.to_s, 'users', user.activation_token, 'activate')
    mail(to: user.email)
  end

  def activation_success_email(user)
    @user = user
    @url  = join(root_url, 'login')
    mail(to: user.email)
  end
end
