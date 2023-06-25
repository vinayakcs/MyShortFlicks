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

require 'test_helper'

class CastTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
