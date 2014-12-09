class ListsController < ApplicationController

  def new
    @list = List.new

    # @user = User.find(params[:user_id])
    # @list.save
  end

  def create
    @list = List.new
    @list.title = params[:list][:title]
    @list.user = current_user
    @list.assign_triggers(params[:triggers])
    @list.favorites.each do |fav|
      fav.create_influence
    end
    @list.save
    current_user.lists << @list 
    redirect_to user_list_path(current_user.id, @list.id)
  end 


  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists
  end

  def show
    @list = List.find(params[:id])
    @lists = current_user.lists
  end

  def edit 
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if params[:list][:category_id].blank? 
      @list.update(list_params_new_category)
    else 
      @category = Category.find(params[:list][:category_id])
      @list.update(list_params)
    end
    current_user.lists << @list 
    # redirect_to user_lists_path(current_user.id, @list.id)
    redirect_to user_path(current_user)
  end


  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to user_lists_path(current_user)
  end


  private

  def list_params
    params.require(:list).permit(:title)
  end

  def favorite_params
    params.require(:favorite).permit(:name, :description, :favorite_image)
  end

  # def list_params
  #   params.require(:list).permit(:title, :category_id)
  # end

  # def list_params_new_category
  #   params.require(:list).permit(:title, :new_category_name)
  # end


end
