class FavoritesController < ApplicationController

  def create
    uploaded_io = params[:favorite][:favorite_image]
    File.open(Rails.root.join('app','assets', 'images', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    @list = List.find(params[:list_id])

    @favorite = @list.favorites.create(favorite_params)
    @favorite.favorite_image = uploaded_io.original_filename
    @favorite.create_influence
    @favorite.save
    # if @favorite.save
    #   respond_to do |f|
    #   f.js
    #   end
    # else
    # end
    redirect_to user_list_path(current_user.id, @list.id)
  end


  def edit
    @list = List.find(params[:list_id])
    @favorite = @list.favorites.find(params[:id])
  end

  def update
    @list = List.find(params[:list_id])
    @favorite = @list.favorites.find(params[:id])
    @favorite.update(favorite_params)
    redirect_to user_list_path(current_user.id, @list.id)
  end

  def poke
    @favorite = Favorite.find(params[:id])
    @list = @favorite.list
    @favorite.influence.pokes.create(:giver_id => current_user.id, :receiver_id => @list.user.id)
    redirect_to user_list_path(current_user.id, @list.id)
  end

  def relist
    @favorite = Favorite.find(params[:id])
    @list = @favorite.list
    @favorite.influence.relists.create(:giver_id => current_user.id, :receiver_id => @list.user.id)
    redirect_to user_list_path(current_user.id, @list.id)
  end

  def destroy
    @list = List.find(params[:list_id])
    @favorite = @list.favorites.find(params[:id])
    @favorite.destroy
    redirect_to user_list_path(current_user.id, @list.id)
  end

  private
  def favorite_params
    params.require(:favorite).permit(:name, :description)
  end

end
