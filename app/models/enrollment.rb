class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student

  validates :course, :student, :price, presence: true
end
