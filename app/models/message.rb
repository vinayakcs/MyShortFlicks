# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  from_user_id :integer
#  to_user_id   :integer
#  read_at      :datetime
#  content      :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Message < ActiveRecord::Base
  belongs_to :from_user,  class_name: 'User', inverse_of: :sent_messages
  belongs_to :to_user,    class_name: 'User', inverse_of: :received_messages

  after_save :update_unread_msg_count_for_to_user

  # validations
  validates :from_user, presence: true
  validates :to_user, presence: true

  validates :content, presence: true, length: { maximum: 600 }


  def self.get_messages_for_receiver(receiver_id,sender_id=nil)
   messageInfo=where( messages.to_user_id=?",receiver_id).joins(:user).where("users.id=messages.from_user_id").select("messages.content,messages.read_at,messages.created_at,users.first_name,users.last_name,users.karma,users.url_token,users.profile_image_url").order("messages.created_at desc")
   messageInfo=messageInfo.where("messages.from_user_id=?",sender_id)
   return messageInfo
  end

  def self.create_message_for_user(send_user,receive_user,msg)
   msg_instance=Message.new
   msg_instance.from_user=send_user
   msg_instance.to_user=receive_user
   msg_instance.content=msg
   msg_instance.save
   return msg_instance 
  end

  def mark_as_read
   read_at=Time.zone.now
  end

  def update_unread_msg_count_for_to_user
   to_user.update_field_count("unread_msg_count",true)
  end

end
