class Challenge < ApplicationRecord
  VISIBILITIES = %w[public private].freeze
  STATUSES     = %w[draft upcoming active completed cancelled].freeze

  belongs_to :creator, class_name: "User"
  belongs_to :category

  has_many :challenge_requests, dependent: :destroy
  has_many :challenge_comments, dependent: :destroy
  has_many :challenge_participations, dependent: :destroy
  has_many :challenge_invites, dependent: :destroy
  has_many :bookmarked_challenges, dependent: :destroy
  has_many :user_badges, dependent: :nullify
  has_many :progress_logs, dependent: :destroy

  has_many :bookmarkers, through: :bookmarked_challenges, source: :user

  validates :name, :description, :start_date, :end_date, :visibility, :status, presence: true
  validates :visibility, inclusion: { in: VISIBILITIES }
  validates :status, inclusion: { in: STATUSES }
  validate :end_after_start

  scope :public_visible, -> { where(visibility: "public") }
  scope :active, -> { where(status: "active") }
  scope :by_category, ->(category_id) { category_id.present? ? where(category_id:) : all }
  scope :by_visibility, ->(visibility) { visibility.present? ? where(visibility:) : all }
  scope :by_status, ->(status) { status.present? ? where(status:) : all }

  private

  def end_after_start
    return if start_date.blank? || end_date.blank?
    errors.add(:end_date, "must be after start date") if end_date <= start_date
  end
end
