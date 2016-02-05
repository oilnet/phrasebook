class Admin::UsersController < Admin::AdminController
  before_filter :find_objects
  
  def index
    # Siehe before_filter.
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
  
  def find_objects
    @users = User.all
  end
end
