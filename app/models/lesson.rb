class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, uniqueness: true
end
