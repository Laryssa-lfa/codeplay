class Course < ApplicationRecord
    validates :name, :code, :price, presence: true
    validates :code, uniqueness: true

    has_one_attached :banner
end
