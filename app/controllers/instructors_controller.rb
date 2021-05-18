class InstructorsController < ApplicationController
    def index
        @instructors = Instructor.all
    end

    def show
        @instructor = Instructor.find(params[:id])
    end

    def new
        @instructor = Instructor.new
    end

    def create
        @instructor = Instructor.create(instructor_params)
        @instructor.profile_picture.attach(io: File.open(Rails.root.join('tmp', 'storage', @instructor.image_name)),
                                           filename: @instructor.image_name, content_type: "image/png" )
        redirect_to @instructor
    end

    private

    def instructor_params
        params.require(:instructor).permit(:name, :email, :bio, :profile_picture, :image_name)
    end
end
