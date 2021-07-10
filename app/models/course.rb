class Course < ApplicationRecord
  belongs_to :instructor

  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy

  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true

  has_one_attached :banner

  scope :available, -> { where(enrollment_deadline: Date.current..) }
  scope :min_to_max, -> { order(price: :asc) }
end
