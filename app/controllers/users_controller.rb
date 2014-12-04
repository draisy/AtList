class UsersController < ApplicationController


  def show 
    @user = User.find(params[:id])
    @lists = @user.lists
    @favorites_count = @user.count_total_favorites
  end

end
