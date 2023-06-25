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

class Icon < ActiveRecord::Base
  include GlobalConstants  
  after_initialize :default_values

  # relations
  has_many :badges, inverse_of: :icon

  # validations
  validates :name, presence: true, length: {maximum: 250}, uniqueness: {scope: :icon_type}
  validates :is_visible, inclusion: { in: [true, false] }
  validates :icon_type, presence: true, length: {maximum: 250}, inclusion: {in: GlobalConstants::ICON_TYPE}
  validates :icon_url, presence: true, length: {maximum: 250}
  validates :badges_count, presence: true, numericality: {only_integer: true}

  scope :get_all_reviews, lambda { where("icon_type= ?",GlobalConstants::ICON_TYPE_REVIEW) }
  scope :get_all_genres, lambda { where("icon_type= ?",GlobalConstants::ICON_TYPE_GENRE) }  

  private
  def default_values
    self.is_visible ||= true
    self.badges_count ||= 0
  end

end
