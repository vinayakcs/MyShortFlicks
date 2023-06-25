# == Schema Information
#
# Table name: videos
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  url_token           :string(255)
#  video_url           :string(255)
#  video_thumbnail_url :string(255)
#  reputation          :integer          default(0)
#  published_at        :datetime
#  featured_at         :datetime
#  claimed_at          :datetime
#  is_nsfw             :boolean          default(FALSE)
#  title               :string(255)
#  description         :text(65535)
#  channels_count      :integer          default(0)
#  impressions_count   :integer          default(0)
#  comments_count      :integer          default(0)
#  badges_count        :integer          default(0)
#  video_urlid         :string(255)
#  duration            :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Video < ActiveRecord::Base
  after_initialize :default_values
  before_validation  :set_video_data
  include VideosHelper
  include Searchable
  include Discoverable
  include GlobalConstants
  include Tokenable
  include Utilitable
  is_impressionable counter_cache: true, column_name: :impressions_count
#for badges via icons
  has_many :badges, inverse_of: :user, dependent: :destroy
  has_many :icons, :through => :badges
  
#for comments
  has_many :comments, as: :commentable, dependent: :destroy
#for channels
  has_many :channelgraphs, dependent: :destroy, inverse_of: :video
#for casts
  has_many :casts, dependent: :destroy



#owner of the video
  belongs_to :user,inverse_of: :videos, counter_cache: true
  # validations
  validates :url_token, presence: true, length: { is: 12 }
  validates :video_url, presence: true, length: {maximum: 550}
  validates :video_thumbnail_url, length: {maximum: 550}
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 150}
  validates :description, length: {maximum: 2750}
  validates :comments_count, presence: true, numericality: { only_integer: true }
  validates :impressions_count, presence: true, numericality: { only_integer: true }
  validates :video_urlid, presence: true

###Scopes
#all non banned videos
  scope :published, lambda { where("published_at < ? ",Time.zone.now) }
#all featured videos
  scope :get_featured, lambda {where("featured_at < ? ",Time.zone.now).order("featured_at desc") }

###Static

#get video,cast,badges results for preview
  def self.get_coagulation_results_for_preview
   includes(:casts).includes(:icons)
  end
#get icons of a given type sorted by count
  def get_top_icons_of_type(type,count)
   if ICON_TYPE.include? type
    Video.joins(:icons).where("icons.icon_type=?",type).group("icons.name").order("icons.badges_count desc").limit(count)
   end
  end
# join is for joining query conditions in case query contains words separated by space 
  def self.search_video_by_keywords(query, join = "AND")
    db_search(query, join, %w[title description])
  end
#video get most viewed and top voted, in recent days
  def self.get_hottest_video
    get_trending(["reputation","impressions_count"],GlobalConstants::VIDEO_TRENDING_NORMALIZER)
  end
#get most top rated video, ever
  def self.get_toprated_video
   get_most_interacted(["reputation"])
  end
#get most viewed video, ever 
  def self.get_most_viewed_video
   get_most_interacted(["impressions_count"])
  end
#get recently created videos
  def self.get_new_video
   get_most_interacted(["created_at"])
  end 
#get wither nsfw enabled or disabled videos
  def self.get_toggled_nsfw_video(is_nsfw=false)
   where("is_nsfw=?",is_nsfw)
  end
#make innerjoin btw video and badges for given icon, group by and sort by count, using joins not includes
  def self.get_videos_for_category(icon_id)
   joins(:badges).where("badges.icon_id=?",icon_id).group("badges.video_id").order("count(badges.video_id) desc")
  end
#get all videos where user is a cast
  def self.get_all_video_casted_by_user(user_id)
   joins(:casts).where("assignee_id=?",user_id)
  end

#in some cases, we can get video properties from db, this method gets the urls
  def self.get_video_url_by_params(url_token,title)
    [url_token,title.parameterize.truncate(200,separator:'')].join("-")    
  end
#get videourl from videoid, when params like url_token and title is not avaialble , dont use this unless params are not there
  def self.get_video_url(video_id)
   videoObj=Video.find(video_id)
   if !videoObj.nil?
    Video.get_video_url_by_params(videoObj.url_token,videoObj.title)
   else
    nil
   end
  end

#get user feeds 
  def self.get_user_feeds(user_id)
   User.get_feeds_for_user(user_id)
  end



###Object
#friendly urls
  def to_param
   Video.get_video_url_by_params(url_token,title)
  end


  private

#uses functions in videos_helper.rb
  def set_video_data
   begin
    self.video_urlid,self.title,self.description,self.duration,self.video_thumbnail_url=get_video_data(self.video_url)
   rescue  GlobalConstants::NON_PERMITTED_HOST_EXCEPTION => e
    self.errors.add(:base, GlobalConstants::NON_PERMITTED_HOST_EXCEPTION)
   rescue  GlobalConstants::BAD_URL_EXCEPTION => e
    self.errors.add(:base, GlobalConstants::BAD_URL_EXCEPTION)
   rescue  GlobalConstants::UNKNOWN_EXCEPTION => e
    self.errors.add(:base, GlobalConstants::UNKNOWN_EXCEPTION)
   end
  end


  def default_values
    self.published_at ||= Time.zone.now
#lets worry about it after 100 years
    self.featured_at ||=  100.years.from_now
  end


end
