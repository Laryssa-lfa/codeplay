class LessonsController < ApplicationController
  before_action :authenticate_student!, only: %i[show]
  before_action :set_lesson, only: %i[show]
  before_action :student_has_enrollment, only: %i[show]

  def show
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def student_has_enrollment
    redirect_to @lesson.course unless current_student.courses.include?(@lesson.course)
  end
end
