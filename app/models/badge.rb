class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, :description, :icon_url, presence: true
  validates :code, uniqueness: true, presence: true
  validates :description, presence: true


  def awarded_to?(user)
    users.exists?(user.id)
  end

  def awarded_count
    user_badges.count
  end
end
