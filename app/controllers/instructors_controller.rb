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
        
        session[:instructor_id] = instructor.id
        @instructor.profile_picture.attach(io: File.open('./storage'), filename: :profile_picture, content_type: "image/png" )
        
        @instructor.save
        redirect_to @instructor
    end

    private

    def instructor_params
        params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
    end
end
