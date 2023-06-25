# == Schema Information
#
# Table name: channels
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  url_token           :string(255)
#  title               :string(255)
#  description         :text(65535)
#  image_url           :string(255)
#  subscriptions_count :integer          default(0)
#  videos_count        :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Channel < ActiveRecord::Base
  include Searchable
  include Tokenable
  include GlobalConstants
  include Discoverable
  include Utilitable
  # relations
  has_many :subscriptions, inverse_of: :user, dependent: :destroy
#channels count in users
  belongs_to :user, inverse_of: :channels, counter_cache: true
#channels count in videos , can help in determining trending or popular videos , most shared videos.

  has_many :videos, through: :channelgraphs
  has_many :channelgraphs, dependent: :destroy, inverse_of: :channel

  # validations
  validates :user, presence: true
  validates :url_token, presence: true, uniqueness: {case_sensitive: true}, length: { is: 12 }
  validates :title, presence: true, uniqueness: {scope: :user_id, case_sensitive: false}
  validates :description, presence: true, length: {maximum: 500}
  validates :subscriptions_count, presence: true, numericality: { only_integer: true }
  validates :videos_count, presence: true, numericality: { only_integer: true }

#coagulate dependency
 def self.get_coagulation_results_for_preview
  includes(:user)
 end
 def self.get_channel_url_by_params(url_token,title)
  [url_token,title.parameterize.truncate(200,separator:'')].join("-")    
 end
 def to_param
  Channel.get_channel_url_by_params(url_token,title)
 end
#search by keywords 
 def self.search_channel_by_keywords(query, join = "AND")
   db_search(query, join, %w[title description])
 end
#get most subscribed channels in recent days
 def self.get_hottest_channels
  get_trending(["subscriptions_count"],GlobalConstants::CHANNEL_TRENDING_NORMALIZER)
 end
#get most subscribed channels , ever
 def self.get_most_subscribed_channels
  get_most_interacted(["subscriptions_count"])
 end
#get recently created channels
 def self.get_new_channel
  get_most_interacted(["created_at"])
 end 


end
