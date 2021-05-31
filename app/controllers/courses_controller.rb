class CoursesController < ApplicationController
    before_action :set_course, only: %i[show edit update destroy enroll]

    def index
        #@courses = Course.all
        @courses = Course.where(enrollment_deadline: Date.current..)
    end

    def show
    end

    def new
        @instructors = Instructor.all
        @course = Course.new
    end

    def create
        @course = Course.new(course_params)
        if @course.save
            redirect_to @course, notice: t('.success')
        else
            @instructors = Instructor.all
            render :new
        end
    end

    def edit
        @instructors = Instructor.all
    end

    def update
        @course = Course.update(course_params)
        redirect_to @course, notice: t('.success')
    end

    def destroy
        @course.destroy
        redirect_to courses_path, notice: t('.success')
    end

    def enroll
        current_user.enrollments.create(course: @course, price: @course.price)
        redirect_to my_courses_courses_path, notice: t('.success')
      end
    
      def my_courses
        @enrollments = current_user.enrollments
      end

    private

    def course_params
        params.require(:course).permit(:name, :description, :code, :price, :banner,
                                       :enrollment_deadline, :instructor_id, :lessons)
    end

    def set_course
        @course = Course.find(params[:id])
    end
end
