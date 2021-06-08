class Api::V1::CoursesController < ActionController::API
  def index
    @courses = Course.all
    render json: @courses
  end

  def show
    @course = Course.find_by!(code: params[:code])
    render json: @course
    
  rescue ActiveRecord::RecordNotFound
      head 404
  end

  def create
    @course = Course.new(course_params)
    @course.save!
    render json: @course, status: :created
  end

  def update
    @course = Course.find_by!(code: params[:code])
    @course.update(course_params)
    render json: @course, status: 200
  end

  def destroy
    @course = Course.find_by!(code: params[:code])
    @course.destroy
    render json: @course, status: 200
  end

  private

    def course_params
        params.require(:course).permit(:name, :description, :code, :price, :banner,
                                       :enrollment_deadline, :instructor_id, :lessons)
    end
end
