class SearchesController < ApplicationController

  def index
    @search = Sunspot.search(Category, User, List, Favorite) do 
      fulltext params[:q], :minimum_match => 0
    end
    @results = @search.results
    hash = @results.group_by {|a| a.class }
    @category_array = hash[Category]
    @list_array = hash[List].collect do |list|
      list.get_list_influence_objects
    end
    @favorite_array = hash[Favorite]
    @user_array = hash[User]

    @list_json = @list_array.to_json
  end 


end



