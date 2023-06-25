# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  url_token           :string(255)
#  email               :string(255)
#  remember_token      :string(255)
#  first_name          :string(255)
#  last_name           :string(255)
#  gender              :string(255)
#  quote               :string(255)      default("Give me a museum and I'll fill it.")
#  karma               :integer          default(0)
#  comments_count      :integer          default(0)
#  votes_count         :integer          default(0)
#  subscriptions_count :integer          default(0)
#  badges_count        :integer          default(0)
#  videos_count        :integer          default(0)
#  channels_count      :integer          default(0)
#  impressions_count   :integer          default(0)
#  unread_msg_count    :integer          default(0)
#  cast_approval_count :integer          default(0)
#  profile_image_url   :string(255)
#  bio                 :text(65535)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
