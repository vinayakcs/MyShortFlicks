# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  votable_id   :integer
#  votable_type :string(255)
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ActiveRecord::Base
  # since polymorphic, no counter cache.
  # https://github.com/rails/rails/issues/16407
  # counter cache has to be implemented
  belongs_to :votable, polymorphic: true
  belongs_to :user, inverse_of: :votes, counter_cache: true


  # validations
  validates :user, presence: true
  validates :user_id, uniqueness: {scope: [:votable_id, :votable_type]}





end
