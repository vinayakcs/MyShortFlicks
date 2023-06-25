# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  channel_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subscription < ActiveRecord::Base

  # relations
  belongs_to :user, inverse_of: :subscriptions, counter_cache: true
  belongs_to :channel, inverse_of: :subscriptions, counter_cache: true

  # validations
  validates :user, presence: true
  validates :channel, presence: true

  validates :user_id, uniqueness: {scope: :channel_id}
  validate :check_subscriber_is_not_channel_owner

  private
  def check_subscriber_is_not_channel_owner
   errors.add(:base,"Subscriber cannot be channel owner") if user==channel.user
  end

end
