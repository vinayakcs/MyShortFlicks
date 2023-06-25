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

class OmniauthAuthentication < ActiveRecord::Base

  ## Relations
  belongs_to :user, inverse_of: :omniauth_authentications

  ## Validations
  validates :user, presence: true
  validates :provider, presence: true, uniqueness: {scope: [:uid]} , inclusion: {in: %w(facebook google_oauth2)}, length: {maximum: 250}
  validates :url, length: {maximum: 250}
  validates :uid, presence: true, length: {maximum: 250}

  ## Methods
  def self.find_with_omniauth(provider,uid)
    find_by(provider: provider, uid: uid)
  end

end
