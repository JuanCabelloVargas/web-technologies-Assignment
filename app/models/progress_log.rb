class ProgressLog < ApplicationRecord
    belongs_to :user
    belongs_to :challenge

    validates :progress_value, :unit, :logged_at, presence: true
end
