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

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_filter :require_login, only: [:index, :new, :create, :activate]

  # GET /users/1
  def show
    # See before_action.
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # See before_action.
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: 'Benutzerkonto wurde angelegt, E-Mail wurde versandt.' # TODO: i18n!
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Daten wurden aktualisiert.' # TODO: i18n!
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to phrases_path, notice: 'Benutzer gelöscht.' # TODO: i18n!
  end
  
  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(sign_in_path, :notice => 'Alles gut, Benutzerkonto aktiviert!') # TODO: i18n!
    else
      not_authenticated
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
