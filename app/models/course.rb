class Course < ApplicationRecord
    belongs_to :instructor

    has_many :lessons
    has_many :enrollments

    validates :name, :code, :price, presence: true
    validates :code, uniqueness: true

    has_one_attached :banner
end
