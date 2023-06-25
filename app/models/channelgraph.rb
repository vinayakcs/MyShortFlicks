# == Schema Information
#
# Table name: channelgraphs
#
#  id         :integer          not null, primary key
#  video_id   :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Channelgraph < ActiveRecord::Base
  belongs_to :channel, inverse_of: :channelgraphs, counter_cache: :videos_count
  belongs_to :video, inverse_of: :channelgraphs, counter_cache: :channels_count

  ## validations
  validates :channel, presence: true
  validates :video, presence: true
  validates :video_id, presence: true, uniqueness: {scope: :channel_id}



  def self.add_video_to_channel(video,channel)
    channel_instance=Channelgraph.new
    channel_instance.video=video
    channel_instance.channel=channel
    channel_instance.save
    return channel_instance
  end
end
