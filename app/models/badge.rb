# == Schema Information
#
# Table name: badges
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  video_id   :integer
#  icon_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Badge < ActiveRecord::Base

  # relations
  belongs_to :user, inverse_of: :badges, counter_cache: true
  belongs_to :video, inverse_of: :badges, counter_cache: true
  belongs_to :icon, inverse_of: :badges, counter_cache: true
  # validations
  validates :user, presence: true
  validates :video, presence: true
  validates :icon, presence: true

  validates :user_id, uniqueness: {scope: [:video_id, :icon_id]}




  def self.add_badge_from_user_to_video(usr,vid,icn)
    badge_instance=Badge.new
    badge_instance.user=usr
    badge_instance.video=vid
    badge_instance.icon=icn
    badge_instance.save
    return badge_instance
  end

#returns a map of icon name and count for given video
  def self.get_badge_count_asmap_for_video(video_id)
   where("badges.video_id=? and icons.is_visible=?",video_id,true).group("badges.icon_id").joins(:icon).select("icons.name as badgeName, count(badges.icon_id) as badgeCount").order("badgeCount desc")
  end
#returns a map of iconname and count by a user on a video, so we can use it to show what a user did, maybe in user profile etc
  def self.get_badge_count_asmap_for_video_by_user(video_id,user_id)
   where("badges.video_id=? and badges.user_id=? and icons.is_visible=?",video_id,user_id,true).group("badges.icon_id").joins(:icon).select("icons.name as badgeName, count(badges.icon_id) as badgeCount")   
  end
#just get user badge_type
  def self.get_user_badge_type_for_video(video_id,user_id,type)
   joins(:icons).where("badges.video_id=? and badges.user_id=? and icons.icon_type=?",video_id,user_id,type)
  end

  


end
