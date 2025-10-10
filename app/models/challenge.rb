class Challenge < ApplicationRecord
    belong_to :user
    belong_to :categorie

    validates :name, :description, :start_date, :end_date, :visibility, :status, presence: true
    

end
