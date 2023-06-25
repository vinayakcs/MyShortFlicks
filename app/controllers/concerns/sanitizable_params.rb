module SanitizableParams
 extend ActiveSupport::Concern
 include ActionView::Helpers::SanitizeHelper
 included do 
     before_action -> {sanitize_inputs params}
 end

  def sanitize_inputs(params)
   params.each do |k,v|
    if v!=nil and v.is_a?(String) 
     params[k]=(sanitize(v, :tags=>[]).strip unless v.nil?)
    end
   end
  end
 

end
