class CoursesController < ApplicationController
    before_action :set_course, only: %i[show edit update destroy]

    def index
        @courses = Course.all
    end

    def show
    end

    def new
        @course = Course.new
    end

    def create
        @course = Course.create(course_params)
        if @course.save
            redirect_to @course, notice: 'Curso criado com sucesso'
        else
            render :new
        end
    end

    private

    def course_params
        params.require(:course).permit(:name, :description, :code, :price, :enrollment_deadline)
    end

    def set_course
        @course = Course.find(params[:id])
    end
end
