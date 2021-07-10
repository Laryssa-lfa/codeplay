class Admin::LessonsController < Admin::AdminController
  before_action :set_lesson, only: %i[show edit update destroy]
  before_action :set_course

  def show; end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.new(lesson_params)
    if @lesson.save
      redirect_to [:admin, @course], notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    @lesson.update(lesson_params)
    redirect_to [:admin, @course], notice: t('.success')
  end

  def destroy
    @lesson.destroy
    redirect_to admin_course_path(params[:course_id]), notice: t('.success')
  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :duration, :content)
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
