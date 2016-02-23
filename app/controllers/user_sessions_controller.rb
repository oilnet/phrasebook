class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]

  # GET /user_sessions/new
  # GET /sign_in
  def new
    @user = User.new
  end

  # POST /user_sessions
  def create
    logger.debug "*** #{params[:user][:email]}, #{params[:user][:password]}"
    if @user = login(params[:user][:email], params[:user][:password], true)
      if @user.admin?
        redirect_to admin_phrases_path
      else
        redirect_back_or_to(:phrases, notice: 'Willkommen!') # TODO: i18n: أهلا وسهلا!
      end
    else
      flash.now[:alert] = 'Benutzername oder Passwort falsch.' # TODO: i18n: اسم مستخدم أو كلمة سر خاطئة
      render action: 'new'
    end
  end

  # GET /user_sessions/destroy
  # GET /sign_out
  def destroy
    logout
    redirect_to(phrases_path, notice: 'Auf Wiedersehen!') # TODO: i18n: إلى اللقاء!
  end
end
