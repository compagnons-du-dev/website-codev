class Admin::UsersController < AdminController
  before_filter :set_user, except: [:index]

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  def update
    @user.update_attributes user_params
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:admin)
  end
  def set_user
    @user = User.find(params[:id])
  end
end