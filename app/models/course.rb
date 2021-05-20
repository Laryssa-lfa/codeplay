class Course < ApplicationRecord
    validates :name, :code, :price, presence: {message: "não pode ficar em branco"}
    validates :code, uniqueness: {message: "já está em uso"}

    has_one_attached :banner
end
