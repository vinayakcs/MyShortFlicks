class VideosController < ApplicationController
 include SanitizableParams
 include MySessionsHelper
 include GlobalConstants
 include Urltokenable
 def show
   @video=search_by_url_token(Video.name.classify.constantize,params)
   puts @video
 end
 def index
  @isLastResults=false
  @videos=Video.published.get_coagulation_results_for_preview
  @videos=@videos.get_toggled_nsfw_video(true) if !params[:nsfw_enabled].blank?
  page_val=1
  page_val=params[:page] if !params[:page].blank?
  @videos=@videos.get_pagination_data(page_val) 
  if !params[:header_search_text].blank?
   @videos=@videos.search_video_by_keywords(params[:header_search_text])
  elsif !params[:filter].blank? && params[:filter]=="hottest_video"
   @videos=@videos.get_hottest_video
  elsif !params[:filter].blank? && params[:filter]=="top_rated_video"
   @videos=@videos.get_toprated_video
  elsif !params[:filter].blank? && params[:filter]=="most_viewed_video"
   @videos=@videos.get_most_viewed_video
  elsif !params[:filter].blank? && params[:filter]=="new_video"
   @videos=@videos.get_new_video
  elsif !params[:filter].blank? && params[:filter]=="category_video"
   @videos=@videos.get_videos_for_category(params[:category_id])
  elsif !params[:filter].blank? && params[:filter]=="featured"
   @videos=@videos.get_featured
  else 
   if my_current_user
    @videos=@videos.get_user_feeds(my_current_user.id)
   else
    @videos=@videos.get_featured
   end
  end
  if @videos.nil? || @videos.empty? || @videos.size<GlobalConstants::VIDEO_PER_PAGE
   @isLastResults=true
  end

  respond_to do |format|
      format.html {@videos}
      format.rss
      format.js { render :file => "videos/load_more.js.erb"}
  end
 end



end
