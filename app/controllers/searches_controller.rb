class SearchesController < ApplicationController
  respond_to :html, :json

  def results 
    @search_query = params[:search]
    @search = Sunspot.search(User, List, Favorite) do
      fulltext params[:search]
      paginate :page => 1, :per_page => 100

      # fulltext params[:q], :minimum_match => 0
    end
    @results = @search.results

    if @results.count == 0
      render :noresults
    end 

    if @results 
      hash = @results.group_by {|a| a.class }
      @list_array = hash[List]
      @user_array = hash[User]
      @favorite_array = hash[Favorite]
    end 

  end

#   def index
#     @query = "?q=#{params[:q].gsub(" ", ("+"))}".strip
#     @search = Sunspot.search(Category, User, List, Favorite) do
#       fulltext params[:q], :minimum_match => 0
#     end
#     @results = @search.results

#     if @results
#       hash = @results.group_by {|a| a.class }
#       @category_array = hash[Category]
#       @list_array = hash[List].collect do |list|
#         list.get_list_influence_objects
#       end if !hash[List].nil?
#     @favorite_array = hash[Favorite]
#     @user_array = hash[User]
#   end

#   @list_array.collect! do |list|
#     {:id => list.id, :score => list.list_score,
#      :name => list.title, :user_id => list.user_id,
#      :user_first_name => list.user.first_name,
#      :photo => list.user.user_image + "?type=large"
#      }
#   end if !@list_array.nil?

#   @favorite_array.collect! do |favorite|
#     {:id => favorite.id, :score => favorite.influence.score,
#      :name => favorite.name, :user_id => favorite.list.user_id,
#      :user_first_name => favorite.list.user.first_name,
#      :description => favorite.description,
#      :photo => favorite.list.user.user_image + "?type=large"
#      }

#   end if !@favorite_array.nil?


#   if List.where('title LIKE ?', "%#{params[:q]}%").count > 0
#     respond_to do |format|
#       format.html
#       format.json { render :json => @list_array.to_json }
#     end
#   elsif Favorite.where('name LIKE ?', "%#{params[:q]}%").count > 0 
#     respond_to do |format|
#       format.html
#       format.json { render :json => @favorite_array.to_json }
#     end
#   elsif @list_array.count > @favorite_array.count
#     respond_to do |format|
#       format.html
#       format.json { render :json => @list_array.to_json }
#     end
#   else
#     respond_to do |format|
#       format.html
#       format.json { render :json => @favorite_array.to_json }
#     end

#   end

# end
end
