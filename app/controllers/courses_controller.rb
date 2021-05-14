class CoursesController < ApplicationController
    def index
        @courses = Course.all
        #if @courses.empty?
        #    flash[:alert] = "Nenhum curso disponível"
        #end
    end

    def show
        @course = Course.find(params[:id])
    end

    def new
        @course = Course.new
    end

    def create
        @course = Course.create(course_params)
        if @course.save
            redirect_to root_path
        else
            flash[:alert] = "Nenhum curso disponível"
            render :new
        end
    end

    private

    def course_params
        params.require(:course).permit(:name, :description, :code, :price, :enrollment_deadline)
    end
end
