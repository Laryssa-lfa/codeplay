class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, uniqueness: true
  validates :name, :duration, :content, presence: true
end
