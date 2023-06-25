module ApplicationHelper
 include GlobalConstants

 def get_url_params(url)
  begin
   if url.nil?
    return nil
   else
    return URI.parse(url).query
   end
  rescue Exception => e
   Rails.logger.error "ApplicationHelper::get_url_params fails #{e} for #{url}"
   raise GlobalConstants::BAD_URL_EXCEPTION
  end
 end

 def get_param_from_url(url,param)
  begin
   query_string=get_url_params(url)
   if !query_string.nil? && query_string.to_s!=''
    parameters=Hash[URI.decode_www_form(query_string)]
    return parameters[param]
   else
    return nil
   end
  rescue Exception => e
   Rails.logger.error "ApplicationHelper::get_param_from_url fails #{e} for #{url} and #{param}"
   raise GlobalConstants::BAD_URL_EXCEPTION
  end
 end

 def get_host_of_url(url)
  begin
   if url.nil?
    return nil
   else
    uri=URI.parse(url)
    return uri.host
   end
  rescue Exception => e
   Rails.logger.error "ApplicationHelper::get_host_of_url fails #{e} for #{url}"
   raise GlobalConstants::BAD_URL_EXCEPTION
  end
 end
 
end
