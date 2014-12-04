class SessionsController < ApplicationController

  # after_action :set_origin_path

  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_by(:provider => auth["provider"], :uid => auth["uid"]) || User.create_with_omniauth_and_koala(auth)
    session[:user_id] = @user.id
    
    # redirect_to session[:origin_path]
    # redirect_to user_lists_path(@user)
      redirect_to main_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  # private
  # def set_origin_path
  #   session[:origin_path] = request.path
  # end

end





