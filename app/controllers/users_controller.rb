class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    #authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = current_user.empresa.users.all
  end

  def show
    @user = current_user.empresa.users.find(params[:id])
  end
  
  # GET /users/1/edit
  def edit
    @sucursales = current_user.empresa.sucursales.all
  end
  
  def update
    #authorize! :update, @user, :message => 'Not authorized as an administrator.'
    params.permit!
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
  
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user.empresa.users.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, empresa_attributes: [:razonsocial, :rfc])
    end
end