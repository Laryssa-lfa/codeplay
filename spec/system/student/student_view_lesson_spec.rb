require 'rails_helper'

describe 'Student view lesson' do
  it 'successfully' do
    student = student_login
    instructor = create(:instructor)
    course = create(:course, name: 'Ruby', instructor: instructor)
    create(:lesson, name: 'Monkey Patch', duration: 20, course: course)
    Enrollment.create!(student: student, course: course, price: course.price)

    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link 'Comprar'
    expect(page).to have_link 'Monkey Patch'
    expect(page).to have_content '20 minutos'
  end

  it 'without enrollment cannot view lesson link' do
    instructor = create(:instructor)
    course = create(:course, name: 'Ruby', instructor: instructor)
    create(:lesson, name: 'Monkey Patch', course: course)

    student_login
    visit root_path
    click_on 'Ruby'

    expect(page).to have_link 'Comprar'
    expect(page).to have_content 'Monkey Patch'
    expect(page).not_to have_link 'Monkey Patch'
  end

  it 'without login cannot view lesson' do
    instructor = create(:instructor)
    course = create(:course, instructor: instructor)
    lesson = create(:lesson, course: course)

    visit course_lesson_path(course, lesson)

    expect(current_path).to eq(new_student_session_path)
  end

  it 'without enrollment cannot view lesson' do
    instructor = create(:instructor)
    course = create(:course, instructor: instructor)
    lesson = create(:lesson, course: course)

    student_login
    visit course_lesson_path(course, lesson)

    expect(current_path).to eq(course_path(course))
    expect(page).to have_link 'Comprar'
  end
end
