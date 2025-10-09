class User < ApplicationRecord
  has_many :challenge_request, foreign_key: requester_id, dependent: :destroy
  has_many :notifiactions, dependent: :destroy
  has_many :bookmarked_challenges, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :challenge_comments, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
