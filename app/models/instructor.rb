class Instructor < ApplicationRecord
    has_one_attached :profile_picture

    def image_name
        "#{name}.png"
    end
end
