module LayoutHelper
 include GlobalConstants
#used to show the title of the html page
 def title(page_title)
  if page_title.to_s==""
   content_for(:title) { h(GlobalConstants::SITE_NAME) }
  else
   content_for(:title) { h(page_title.to_s) }
  end
 end 
 def get_category_list
  Icon.get_all_genres
 end
 def truncate_preview_title(title)
  truncate(title, length: 65)
 end
 def truncate_preview_description(desc)
  truncate(desc, length: 160)
 end
 def render_video_based_on_host(video)
  is_permitted,host_name=validate_video_host(video.video_url)
  if is_permitted==true
   if host_name=GlobalConstants::YOUTUBE_HOST
     render :partial => 'videos/youtube_video', :locals => {:video => video}
   elsif host_name=GlobalConstants::VIMEO_HOST
     render :partial => 'videos/vimeo_video', :locals => {:video => video} 
   end
  end
 end
end
