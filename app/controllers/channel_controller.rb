class ChannelsController < ApplicationController
  def index
   if !params[:header_search_text].blank?
    Channel.search_channel_by_keywords(params[:header_search_text])
   elsif !params[:filter].blank? && params[:filter]=="hottest_channel"
    Channel.get_hottest_channels
   elsif !params[:filter].blank? && params[:filter]=="most_subscribed_channels"
    Channel.get_most_subscribed_channels
   elsif !params[:filter].blank? && params[:filter]=="new_channel"
    Channel.get_new_channel
   else
    redirect_to root_path
   end
   respond_to do |format|
      format.html
      format.js
   end
  end

  def update
  end

  def destroy
  end
end
