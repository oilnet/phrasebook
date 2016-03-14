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
        redirect_back_or_to(:phrases, notice: t('user_sessions.created', default: 'Welcome!'))
      end
    else
      flash.now[:alert] = t('user_sessions.not_created', default: 'Wrong username or password')
      render action: 'new'
    end
  end

  # GET /user_sessions/destroy
  # GET /sign_out
  def destroy
    logout
    redirect_to(phrases_path, notice: t('user_sessions.destroyed', default: 'Good bye!'))
  end
end
