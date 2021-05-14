class Course < ApplicationRecord
    validates :name, :description, :code, :price, :enrollment_deadline, presence: true
end
