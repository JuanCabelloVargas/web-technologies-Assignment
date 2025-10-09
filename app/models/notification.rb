class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :related, polymorphic: true

  validates :title, :notification_type, presence: true
end
