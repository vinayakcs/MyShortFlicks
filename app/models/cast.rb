# == Schema Information
#
# Table name: casts
#
#  id                :integer          not null, primary key
#  video_id          :integer
#  assignee_id       :integer
#  assignor_id       :integer
#  cast_type         :string(255)
#  assignee_approved :boolean
#  votes_count       :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Cast < ActiveRecord::Base
 include Utilitable
 include GlobalConstants
 after_initialize :default_values
  
 belongs_to :video
 belongs_to :assignee, class_name: "User", inverse_of: :casts
 belongs_to :assignor, class_name: "User", inverse_of: :assignor_roles
 has_many :votes, as: :votable, dependent: :destroy

 # validations
 validates :video, presence: true

 validates :assignee, presence: true
 validates :assignor, presence: true

 validates :cast_type, presence: true, length: {maximum: 250}, inclusion: { in: GlobalConstants::CAST_TYPE}

 validates :assignee_approved, inclusion: { in: [true, false] }
 validates :votes_count, presence: true, numericality: { only_integer: true }

 validates :video_id, uniqueness: {scope: [:assignee_id, :cast_type]}

 validate :check_assignee_owner_of_video


#get cast and video info when a assignee(is looking at request for confirmation) or assignor (is looking at status) is accessing
 def self.get_cast_approval(user_id,is_assignee=true,video_id=nil,assignee_approved=false)
  if is_assignee==false
   role="assignor_id"
  else
   role="assignee_id"
  end
  cast_info=Cast.where("casts.#{role}=? and casts.assignee_approved=?",user_id,assignee_approved).order("casts.created_at desc").joins(:video).select("videos.video_thumbnail_url as videoImage, videos.title as videoTitle, videos.url_token as videoUrlToken, casts.assignor_id as assignor, casts.cast_type as role, casts.created_at as requestTime, casts.assignee_approved as approvalStatus")
  cast_info=cast_info.where("videos.id=?",video_id) if !video_id.nil?  
  return cast_info 
 end
#displaying cast info on video page
 def self.get_cast_for_video(video_id)
  where("casts.video_id=?",video_id).joins(:user).where("casts.assignee_id=users.id").select("users.first_name,users.last_name,users.karma,users.profile_image_url,casts.votes_count,casts.cast_type").order("casts.votes_count desc")
 end


  private
  def default_values
    self.assignee_approved ||= false
    self.votes_count ||= 0
  end
  def check_assignee_owner_of_video
   errors.add(:base,"Assignor must be owner of the video") unless assignor==video.user
  end

end
