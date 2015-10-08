class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :require_login, :only => [:index, :new, :create, :activate]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: 'Benutzerkonto wurde angelegt, E-Mail wurde versandt.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Daten wurden aktualisiert.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'Benutzer gelöscht.'
  end
  
  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(sign_in_path, :notice => 'Alles gut, Benutzerkonto aktiviert!')
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
