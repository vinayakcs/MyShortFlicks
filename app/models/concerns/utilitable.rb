module Utilitable
 include GlobalConstants
 extend ActiveSupport::Concern
 included do
  def update_field_count(field,is_increment=true,value=1)
   if is_increment==true
    increment!(field.to_sym, value)
   else
    decrement!(field.to_sym, value)
   end 
  end


  def self.get_pagination_data(page_val)
   limit=0
   offset=0
   if self.name.classify.constantize.to_s=="Video"
    limit=GlobalConstants::VIDEO_PER_PAGE
    offset=(page_val.to_i-1)*GlobalConstants::VIDEO_PER_PAGE
   elsif self.name.classify.constantize.to_s=="Channel"
    limit=GlobalConstants::CHANNEL_PER_PAGE
    offset=(page_val.to_i-1)*GlobalConstants::CHANNEL_PER_PAGE
   elsif self.name.classify.constantize.to_s=="User"
    limit=GlobalConstants::USER_PER_PAGE
    offset=(page_val.to_i-1)*GlobalConstants::USER_PER_PAGE
   end
   puts limit
   puts offset
   limit(limit).offset(offset)
  end
 end
end
