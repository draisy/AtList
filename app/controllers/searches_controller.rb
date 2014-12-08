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

    @list_array.collect! do |list|
      {:id => list.id, :list_score => list.list_score,
       :title => list.title, :user_id => list.user_id,
       :user_first_name => list.user.first_name}
    end
    @list_json = @list_array.to_json

  end


end
