module Tokenable
 extend ActiveSupport::Concern

 #get random url, chance of collision is 2^size
 def get_urlsafe_token(size)  
  SecureRandom.hex(size)
 end

 #keep trying until a uuid is got; size is 9, 4/3 of 9 is 12
 def get_rand_token(model,field="url_token")
  begin
   rand_token=get_urlsafe_token(6)
  end while model.exists?(field.to_sym => rand_token)
   rand_token
 end

 included do
  before_validation :set_url_token, on: :create

  def set_url_token
   self.url_token=get_rand_token(self.class.name.classify.constantize,"url_token") 
  end
 end

end
