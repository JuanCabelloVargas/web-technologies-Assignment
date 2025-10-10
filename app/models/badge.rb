class Badge < ApplicationRecord
    validates :name, :description, :icon_url, presence: true
    validates :code, uniqueness: true, presence: true
end
