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

require 'test_helper'

class BadgeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
