class ChallengeRequest < ApplicationRecord
  belongs_to :challenge
  belongs_to :requester, class_name: "User"
  belongs_to :decided_by, class_name: "User", optional: true

  validates :status, presence: true
  validates :requester_id, uniqueness: { scope: :challenge_id }
end
