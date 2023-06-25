# == Schema Information
#
# Table name: icons
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  is_visible   :boolean          default(TRUE)
#  icon_type    :string(255)      default("badge")
#  icon_url     :string(255)
#  badges_count :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class IconTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
