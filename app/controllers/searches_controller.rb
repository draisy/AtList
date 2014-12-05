class SearchesController < ApplicationController

  def index

    @search = Sunspot.search(Category, User, List, Favorite) do 
      keywords(params[:q])
    end
    @results = @search.results
    binding.pry
  end 

  #   @search = Category.search do 
  #     keywords(params[:q])
  #   end
  #   binding.pry
  # end


end



