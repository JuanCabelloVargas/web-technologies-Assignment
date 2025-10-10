class ChallengeInvite < ApplicationRecord
    belong_to :challenge
    belong_to :inviter_id, class name: "users"
    belong_to :invitee_user_id, class name: "users"
    validates :inviter_id, :invitee_user_id, uniqueness: true, presence: true
    validates :accepted_at, :is_accepted, presence: true
end