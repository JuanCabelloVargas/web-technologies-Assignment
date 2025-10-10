
class ChallengeInvite < ApplicationRecord
  belongs_to :challenge
  belongs_to :inviter,      class_name: "User", foreign_key: :inviter_id
  belongs_to :invitee_user, class_name: "User", foreign_key: :invitee_user_id

  validates :inviter_id, :invitee_user_id, presence: true
  validates :accepted_at, presence: true

  validates :is_accepted, inclusion: { in: [ true, false ] }

  validates :invitee_user_id, uniqueness: { scope: [ :inviter_id, :challenge_id ],
                                            message: "has already been invited to this challenge" }
end
