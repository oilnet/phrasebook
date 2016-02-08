class Admin::UsersController < Admin::AdminController
  before_filter :find_objects
  
  def index
    # Siehe before_filter.
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      redirect_to [:admin, @user], notice: 'Benutzer gespeichert.'
    else
      flash[:alert] = 'Benutzer konnte nicht gespeichert werden.'
      render action: 'show'
    end
  end
  
  private
  
  def find_objects
    @users = User.all
    @user = User.find(params[:id]) if params[:id]
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :activation_state, :name, :admin)
  end
end
