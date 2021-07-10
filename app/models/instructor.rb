class Instructor < ApplicationRecord
  has_many :courses, dependent: :destroy

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  has_one_attached :profile_picture

  def display_name
    "#{name} - #{email}"
  end
end
