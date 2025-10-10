class Challenge < ApplicationRecord
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
end
