class Category < ApplicationRecord
  has_many :challenges, dependent: :nullify

  before_validations :normalize_name



  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 80 }

  private

  def normalize_name
    self.name = name.to_s.strip.squeeze(" ")
  end
end
