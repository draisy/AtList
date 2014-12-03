class FavoritesController < ApplicationController

  def create
    raise params.inspect
    @list = List.find(params[:list_id])
    @favorite = @list.favorites.build(favorite_params)
    if @favorite.save
      respond_to do |f|
      f.js
      end 
    else
    end 
  end

  def destroy
    @list = List.find(params[:list_id])
    @favorite = @list.favorites.find(params[:id])
    @favorite.destroy
 end

  private
  def favorite_params
    params.require(:favorite).permit(:name, :description, :favorite_image)
  end

end







