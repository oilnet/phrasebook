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
      redirect_to [:admin, @user], notice: t('admin.users.updated', default: 'User saved.')
    else
      flash[:alert] = t('admin.users.not_updated', default: 'User could not be saved.')
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
