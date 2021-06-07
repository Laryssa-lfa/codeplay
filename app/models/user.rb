class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :validatable,
         :recoverable, :rememberable, :registerable

  has_many :enrollments
  has_many :courses, through: :enrollments
end
