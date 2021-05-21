class InstructorsController < ApplicationController
    before_action :set_instructor, only: %i[show edit update destroy]

    def index
        @instructors = Instructor.all
    end

    def show
    end

    def new
        @instructor = Instructor.new
    end

    def create
        @instructor = Instructor.create(instructor_params)
        if @instructor.save
            redirect_to @instructor, notice: t('.success')
        else
            render :new
        end
    end

    def edit
    end

    def update
        @instructor.update(instructor_params)
        redirect_to @instructor, notice: t('.success')
    end

    def destroy
        @instructor.destroy
        redirect_to instructors_path, notice: t('.success')
    end

    private

    def instructor_params
        params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
    end

    def set_instructor
        @instructor = Instructor.find(params[:id])
    end
end
