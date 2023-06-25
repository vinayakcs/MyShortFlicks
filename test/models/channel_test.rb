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

require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
