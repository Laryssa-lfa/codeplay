class CoursesController < ApplicationController
  before_action :authenticate_student!, only: %i[my_courses]
  before_action :set_course, only: %i[show enroll]

  def show; end

  def enroll
    current_student.enrollments.create!(course: @course, price: @course.price)
    redirect_to my_courses_courses_path, notice: t('.success')
  end

  def my_courses
    @enrollments = current_student.enrollments
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
