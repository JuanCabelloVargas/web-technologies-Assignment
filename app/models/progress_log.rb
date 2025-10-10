class ProgressLog < ApplicationRecord
    belong_to :user
    belong_to :challenge

    validates :progress_value, :unit, :logged_at, presence: true
end
