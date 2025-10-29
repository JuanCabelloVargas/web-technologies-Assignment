class ProgressLog < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  validates :progress_value, :unit, :logged_at, presence: true
  validates :progress_value, numericality: true
  validates :unit, length: { maximum: 10 }

  scope :recent, -> { order(logged_at: :desc) }
  scope :for_challenge, ->(challenge_id) { where(challenge_id:) }
  scope :for_user, ->(user_id) { where(user_id:) }
end
