class ChannelsController < ApplicationController
  include GlobalConstants
  include SanitizableParams
  include Urltokenable
  def show
   @channel=search_by_url_token(Channel.name.classify.constantize,params)
  end
  def index
   @isLastResults=false
   @channels=Channel.get_coagulation_results_for_preview
   page_val=1
   page_val=params[:page] if !params[:page].blank?
   @channels=@channels.get_pagination_data(page_val) 
   if !params[:header_search_text].blank?
    @channels=@channels.search_channel_by_keywords(params[:header_search_text])
   elsif !params[:filter].blank? && params[:filter]=="hottest_channel"
    @channels=@channels.get_hottest_channels
   elsif !params[:filter].blank? && params[:filter]=="most_subscribed_channels"
    @channels=@channels.get_most_subscribed_channels
   elsif !params[:filter].blank? && params[:filter]=="new_channel"
    @channels=@channels.get_new_channel
   else
    puts params
    redirect_to root_path
   end
   if @channels.nil? || @channels.empty? || @channels.size<GlobalConstants::CHANNEL_PER_PAGE
    @isLastResults=true
   end 
   respond_to do |format|
      format.html {@channels}
      format.js { render :file => "channels/load_more.js.erb"}
   end
  end

  def update
  end

  def destroy
  end
end
