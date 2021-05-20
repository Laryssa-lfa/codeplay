class Instructor < ApplicationRecord
    has_one_attached :profile_picture

    validates :name, :email, presence: {message: "está em branco, por favor preencher."}
    validates :email, uniqueness: {message: "já em uso!"}
end
