class SessionsController < ApplicationController


  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to dashboard_path
    else
      flash[:error] = "Couldn't find your credentials, try again!"
      redirect_to login_path
    end
  end
end