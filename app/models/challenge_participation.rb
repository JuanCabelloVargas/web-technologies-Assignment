class ChallengeParticipation < ApplicationRecord
  belongs_to :challenge
  belongs_to :user

  STATUSES = %w[pending active completed removed].freeze

  before_validation :set_joined_at

  validates :status, :joined_at, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :total_points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :user_id, uniqueness: { scope: :challenge_id, message: "already joined this challenge" }

  scope :for_user, ->(user_id) { where(user_id:) }
  scope :for_challenge, ->(challenge_id) { where(challenge_id:) }

  private

  def set_joined_at
    self.joined_at ||= Time.current
  end
end
