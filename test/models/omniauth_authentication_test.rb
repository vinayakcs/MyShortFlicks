# == Schema Information
#
# Table name: omniauth_authentications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class OmniauthAuthenticationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
