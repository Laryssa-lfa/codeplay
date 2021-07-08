class Admin::CoursesController < Admin::AdminController
    before_action :set_course, only: %i[show edit update destroy]

    def index
        @courses = Course.all
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
            redirect_to [:admin, @course], notice: t('.success')
        else
            @instructors = Instructor.all
            render :new
        end
    end

    def edit
        @instructors = Instructor.all
    end

    def update
        @course.update(course_params)
        redirect_to [:admin, @course], notice: t('.success')
    end

    def destroy
        @course.destroy
        redirect_to admin_courses_path, notice: t('.success')
    end

    def my_courses
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
