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

require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
