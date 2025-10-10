class ChallengeParticipation < ApplicationRecord
    belongs_to :challenge
    belongs_to :user

    validates :status, :joined_at, presence: true
    validates :total_points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
