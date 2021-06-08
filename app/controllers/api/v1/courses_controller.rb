class Api::V1::CoursesController < Api::V1::ApiController

  def index
    @courses = Course.all
    render json: @courses
  end

  def show
    @course = Course.find_by!(code: params[:code])
    render json: @course
  end

  def create
    @course = Course.new(course_params)
    @course.save!
    render json: @course, status: :created
  rescue ActionController::ParameterMissing
    render status: :precondition_failed, json: { errors: 'parâmetros inválidos' }
  end

  def update
    @course = Course.find_by!(code: params[:code])
    @course.update!(course_params)
    render json: @course, status: 200
  end

  def destroy
    @course = Course.find_by!(code: params[:code])
    @course.destroy!
    render json: @course, status: 200
  end

  private

    def course_params
        params.require(:course).permit(:name, :description, :code, :price, :banner,
                                       :enrollment_deadline, :instructor_id, :lessons)
    end
end
