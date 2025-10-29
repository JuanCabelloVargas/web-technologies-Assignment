class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { user: 0, admin: 1, creator: 2 }

  has_many :bookmarked_challenges,    dependent: :destroy
  has_many :challenge_comments,       dependent: :destroy
  has_many :challenge_participations, dependent: :destroy
  has_many :progress_logs,            dependent: :destroy
  has_many :notifications,            dependent: :destroy
  has_many :user_badges,              dependent: :destroy

  has_many :requests_made,    class_name: "ChallengeRequest", foreign_key: :requester_id,   dependent: :destroy
  has_many :requests_decided, class_name: "ChallengeRequest", foreign_key: :decided_by_id,  dependent: :nullify
  has_many :invites_sent,     class_name: "ChallengeInvite",  foreign_key: :inviter_id,     dependent: :destroy
  has_many :invites_received, class_name: "ChallengeInvite",  foreign_key: :invitee_user_id, dependent: :destroy
  has_many :challenges_created, class_name: "Challenge", foreign_key: :creator_id, dependent: :destroy

  validates :username, presence: true
  validates :email,    presence: true, uniqueness: true
  validates :role,     presence: true

  def display_name
    username.presence || email
  end
end
