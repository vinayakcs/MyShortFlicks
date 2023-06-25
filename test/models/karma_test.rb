# == Schema Information
#
# Table name: karmas
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  event_type  :string(255)
#  event_value :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class KarmaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
