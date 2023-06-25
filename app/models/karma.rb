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

class Karma < ActiveRecord::Base
 belongs_to :user, inverse_of: :karma
 validates :user, presence: true, uniqueness: {scope: :event_type}
end
