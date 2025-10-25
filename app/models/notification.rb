class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :related, polymorphic: true, optional: true

  validates :title, :body, :notification_type, presence: true
end
