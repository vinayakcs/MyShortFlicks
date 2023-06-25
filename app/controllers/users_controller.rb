class UsersController < ApplicationController
  include Urltokenable
  def show
   @user=search_by_url_token(User.name.classify.constantize,params)
  end
  def index
   @users=nil
   if !params[:header_search_text].blank?
    @users=User.search_user_by_name(params[:header_search_text])
   end
   respond_to do |format|
      format.html {@users}
      format.js
   end
  end

end
