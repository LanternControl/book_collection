class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to '/login'
      end

  def correct_user
    @user = User.find(params[:id])
    redirect_to('/') unless @user == current_user
  end

end
end
