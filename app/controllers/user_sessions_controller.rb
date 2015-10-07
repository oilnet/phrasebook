class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:users, notice: t('.sign_in_successful'))
    else
      flash.now[:alert] = t('.sign_in_failed')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: '.signed_out')
  end
end
