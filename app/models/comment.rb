# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#  content          :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user, inverse_of: :comments

  validates :user, presence: true
  validates :content, presence: true


  def self.get_comments_for_video(video_id)
   where("comments.commentable_id=? and comments.commentable_type='Video'",video_id).joins(:user).where("comments.user_id=users.id").order("created_at desc").select("comments.content,comments.created_at,users.url_token,users.first_name,users.last_name,users.profile_image_url,users.karma")
  end


end
