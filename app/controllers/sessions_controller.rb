class SessionsController < ApplicationController
  def index
  end
  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to '/login'
    end
  end

  def destroy
    logout
    flash[:notice] = "Successfully logged out."
    redirect_to "/"
  end

private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
