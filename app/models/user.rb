# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  url_token           :string(255)
#  email               :string(255)
#  remember_token      :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  gender              :string(255)
#  quote               :string(255)      default("Give me a museum and I'll fill it.")
#  karma               :integer          default(0)
#  comments_count      :integer          default(0)
#  votes_count         :integer          default(0)
#  subscriptions_count :integer          default(0)
#  badges_count        :integer          default(0)
#  videos_count        :integer          default(0)
#  channels_count      :integer          default(0)
#  impressions_count   :integer          default(0)
#  unread_msg_count    :integer          default(0)
#  cast_approval_count :integer          default(0)
#  profile_image_url   :string(255)
#  bio                 :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class User < ActiveRecord::Base
  include Searchable
  include Discoverable
  include Tokenable
  include GlobalConstants
  include Utilitable
  #when user creates profile, sigin flow is not triggered hence get the remember token from here 
  before_validation :set_remember_token, on: :create

  is_impressionable :counter_cache => true, :column_name => :impressions_count
#user multi-login single account
  has_many :omniauth_authentications, inverse_of: :user, dependent: :destroy
#user owned channels
  has_many :channels, inverse_of: :user, dependent: :destroy
#user subscribed channels
  has_many :subscriptions, inverse_of: :user, dependent: :destroy
#badges awarded by user
  has_many :badges, inverse_of: :user, dependent: :destroy
#comments made by user
  has_many :comments, as: :commentable, inverse_of: :user, dependent: :destroy
#votes awarded by user
  has_many :votes, as: :votable, inverse_of: :user, dependent: :destroy
#casts
  has_many :casts, inverse_of: :assignee, foreign_key: "assignee_id", dependent: :destroy
  has_many :assignor_roles, class_name: "Cast", foreign_key: "assignor_id", inverse_of: :assignor, dependent: :destroy
#messaging
  has_many :received_messages,  class_name: 'Message', foreign_key: 'to_user_id', inverse_of: :to_user
  has_many :sent_messages,      class_name: 'Message', foreign_key: 'from_user_id', inverse_of: :from_user
#stores karma events, no dependent destroy, this is for archival
  has_many :karmas, inverse_of: :user
#user owned video 
  has_many :videos, inverse_of: :user

  validates :url_token, presence: true, uniqueness: {case_sensitive: true}, length: { is: 12 }
  validates :remember_token, presence: true, uniqueness: {case_sensitive: true }, length: { is: 12 }


  validates :gender, allow_nil: true, inclusion: {in: GlobalConstants::USER_SEX}, length: {maximum: 250}
  validates :email, length: {maximum: 250}
  validates :first_name, length: {maximum: 250}
  validates :last_name, length: {maximum: 250}

  validates :channels_count, presence: true, numericality: { only_integer: true }
  validates :impressions_count, presence: true, numericality: { only_integer: true }
  validates :subscriptions_count, presence: true, numericality: { only_integer: true }

  validates :comments_count, presence: true, numericality: { only_integer: true }
  validates :votes_count, presence: true, numericality: { only_integer: true }

  validates :quote, length: {maximum: 250}


  ## Methods
  def self.new_remember_token
    get_remember_token
  end

#search user
  def self.search_user_by_name(query, join = "AND")
    db_search(query, join, %w[first_name last_name])
  end


#get cast assignee approval notifications
  def check_and_get_cast_approvals(video_id)
   if cast_approval_count>0
    Cast.get_cast_approval(id,true,video_id)
   end
  end
#get cast assignor status
  def get_cast_request_status_for_video(video_id)
   Cast.get_cast_approval(id,false,video_id)
  end
#url slug friendly
  def self.get_user_url_by_params(url_token,first_name,last_name)
    [url_token,truncate(first_name.parameterize+"-"+last_name.parameterize,length:200,omission:'')].join("-")    
  end
#get user unique url from userid
  def self.get_user_url(user_id)
   userObj=User.find(user_id)
   if !userObj.nil?
    self.get_user_url_by_params(userObj.url_token,userObj.first_name,userObj.last_name)
   else
    nil
   end
  end
#used by rails to create url
  def to_param
   self.get_user_url_by_params(url_token,first_name,last_name)
  end
#timeline
  def self.get_feeds_for_user(user_id)
   User.joins("inner join subscriptions on subscriptions.user_id=users.id inner join channelgraphs on channelgraphs.channel_id=subscriptions.channel_id inner join videos on videos.id=channelgraphs.video_id").where("users.id=?",user_id).select("videos.title,videos.description,videos.video_thumbnail_url").order("channelgraphs.created_at desc")
  end
#profile view graph in user profile  
  def self.get_views_graph(user_id,days_range=30)
   User.select("count(impressions.id) as views_per_day,date(impressions.created_at) as day").order("day desc").joins(:impressions).group("day").limit(days_range)
  end
#channel subscription graph in user profile
  def self.get_subscription_graph(user_id,channel_id=nil,days_range=30)
   subscription_info= User.select("count(subscriptions.id) as subscriptions_per_day,date(subscriptions.created_at) as day").order("day desc").group("day").joins("inner join channels on channels.user_id=users.id inner join subscriptions on subscriptions.channel_id=channels.id")
   subscription_info=subscription_info.where("channels.id=?",channel_id) if !channel_id.nil?
   return subscription_info
  end


#add badge to video
  def add_badge_to_video(video,icon)
   badge_instance=Badge.add_badge_from_user_to_video(self,video,icon)
   return badge_instance
  end
#adds a video to existing channel owned by user
  def add_video_to_channel(video,channel)
   channel_instance=nil
   if !video.nil? && !channel.nil? && id==channel.user_id
    channel_instance=Channelgraph.add_video_to_channel(video,channel)
   end 
   return channel_instance
  end
#creates and sends message to another user
  def send_message_to_user(to_user,content)
   message_instance=Message.create_message_for_user(self,to_user,content)
   return message_instance
  end



  private
  def set_remember_token
   self.remember_token=get_remember_token
  end
  
  def get_remember_token
   get_rand_token(self.class.name.classify.constantize,"remember_token")
  end

end
