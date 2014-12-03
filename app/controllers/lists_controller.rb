class ListsController < ApplicationController

  def new
    @list = List.new
    @category = Category.new
    @user = User.find(params[:user_id])
  end

  def create
    @category = Category.find(params[:list][:category_id])
    if @category 
      @category.lists.build(list_params)
    else 
      List.create(list_params)
    end
    @user = User.find(params[:user_id])
    @user_list = @user.lists.build(list_params)
    redirect_to user_list_path(@user_list)
  end 


  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists
  end

  def show
  end


  private
  def list_params
    params.require(:list).permit(:title, :category_id, :new_category_name)
  end

  # def category_params
  #   params.require(:category).permit(:id)
  # end


end
