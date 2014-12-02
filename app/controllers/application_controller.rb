class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :user_friends

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def user_friends
      # facebook.get_connections(current_user, "friends")

    end
end
