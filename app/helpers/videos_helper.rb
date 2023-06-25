module VideosHelper
 include GlobalConstants
 include ApplicationHelper
 require 'open-uri'
 require 'rest-client'
 require 'json'
#basic url utilities in this module are accessed from application helper

#orchestrate the process
 def get_video_data(url)
  begin
   video_id,host_name=get_video_id_facade(url)
   if host_name=GlobalConstants::YOUTUBE_HOST
    get_data_from_youtube(video_id)
   elsif host_name=GlobalConstants::VIMEO_HOST
    get_data_from_vimeo(video_id)
   end
  rescue GlobalConstants::NON_PERMITTED_HOST_EXCEPTION => e
   raise GlobalConstants::NON_PERMITTED_HOST_EXCEPTION
  rescue GlobalConstants::BAD_URL_EXCEPTION => e
   raise GlobalConstants::BAD_URL_EXCEPTION
  rescue Exception => e
   raise GlobalConstants::UNKNOWN_EXCEPTION
  end
 end

#facade pattern for abstraction
 def get_video_id_facade(url)
  begin
   video_identity=nil
   is_permitted,host_name=validate_video_host(url)
   if is_permitted==true
    if host_name=GlobalConstants::YOUTUBE_HOST
     video_identity=get_video_id_for_youtube(url)
    elsif host_name=GlobalConstants::VIMEO_HOST
     video_identity=get_video_id_for_vimeo(url)
    end
   else
     raise GlobalConstants::NON_PERMITTED_HOST_EXCEPTION
   end
   return video_identity,host_name
  rescue GlobalConstants::BAD_URL_EXCEPTION => e
   raise GlobalConstants::BAD_URL_EXCEPTION
  end
 end


#returns hostname and says whether its permitted or not
 def validate_video_host(url)
  begin
   permitted=false
   host=get_host_of_url(url)
   if host.nil? || host.length<=0
    return permitted,nil
   end
   GlobalConstants::PERMISSIBLE_VIDEO_HOST.each do |host_name|
    if host.downcase().include? host_name
     permitted=true
     return permitted,host_name
    end
   end
  rescue GlobalConstants::BAD_URL_EXCEPTION => e
   raise GlobalConstants::BAD_URL_EXCEPTION 
  rescue Exception => e
   Rails.logger.error "VideosHelper::validate_video_host fails for #{urll} #{e}"
   raise GlobalConstants::UNKNOWN_EXCEPTION
  end
 end

 private
#get v param
 def get_video_id_for_youtube(youtube_url)
   get_param_from_url(youtube_url,'v')
 end
#get id from vimeo, examples http://player.vimeo.com/video/67019023 , http://vimeo.com/670190233 https://vimeo.com/channels/staffpicks/130401504
 def get_video_id_for_vimeo(url)
  begin
#FIXME use a good regex
   return url.match(/vimeo\.com(.*?)\/([0-9]+)/)[2]
  rescue Exception => e
   Rails.logger.error "VideosHelper::get_video_id_for_vimeo fails for #{urll} #{e}"
   raise GlobalConstants::BAD_URL_EXCEPTION
  end
 end




#make vimeo api enquiry
 def get_data_from_vimeo(vimeo_id)
  begin
   if vimeo_id.nil?
    return nil
   end
   vimeo_api="http://vimeo.com/api/v2/video/#{vimeo_id}.json"
   data_response=open(vimeo_api).read
   data_json=JSON.parse(data_response)[0]
   return vimeo_id,data_json['title'],data_json['description'],data_json['duration'],data['thumbnail_large']
  rescue Exception => e
   Rails.logger.error "VideosHelper::get_data_from_vimeo fails for #{vimeo_id} #{e}"
   raise GlobalConstants::UNKNOWN_EXCEPTION
  end
 end
#make youtube api enquiry
 def get_data_from_youtube(youtube_id)
  begin
   youtube_api_key=ENV["YOUTUBE_API_KEY"]
   youtube_api="https://www.googleapis.com/youtube/v3/videos?id=#{youtube_id}&key=#{youtube_api_key}&part=snippet,contentDetails&fields=items%28snippet%28title,description%29,contentDetails%28duration%29%29"
   response = RestClient.get(youtube_api, {accept: :json})
   data_json=JSON.parse(response.body)
   youtube_thumbnail_url="http://img.youtube.com/vi/#{youtube_id}/0.jpg"
   return youtube_id,data_json["items"][0]["snippet"]["title"],data_json["items"][0]["snippet"]["description"],data_json["items"][0]["contentDetails"]["duration"],youtube_thumbnail_url
  rescue Exception => e
   Rails.logger.error "VideosHelper::get_data_from_youtube fails for #{youtube_id} #{e}"
   raise GlobalConstants::UNKNOWN_EXCEPTION
  end
 end
end
