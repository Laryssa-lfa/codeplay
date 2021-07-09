require 'rails_helper'

describe 'Student view enrolled courses' do
  it 'successfully' do
    student = student_login
    instructor = create(:instructor)
    course = create(:course, name: 'Ruby', price: 10, instructor: instructor)
    other_course = create(:course, name: 'Ruby on Rails', price: 20, instructor: instructor)
    enrollment1 = Enrollment.create!(student: student, course: course, price: course.price)
    enrollment2 = Enrollment.create!(student: student, course: other_course, price: other_course.price)
    
    visit root_path
    click_on 'Meus Cursos'

    expect(page).to have_content('Ruby')
    expect(page).to have_content("Comprado em: #{enrollment1.created_at}")
    expect(page).to have_content('por R$ 10,00')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content("Comprado em: #{enrollment2.created_at}")
    expect(page).to have_content('por R$ 20,00')
  end

  it 'without login cannot view enrolled courses' do
    visit my_courses_courses_path

    expect(current_path).to eq(new_student_session_path)
  end

  it 'without enrollment cannot view enrolled courses' do
    instructor = create(:instructor)
    create(:course, name: 'Ruby', price: 10, instructor: instructor)

    student_login
    visit my_courses_courses_path

    expect(page).to have_content('Nenhum Curso Comprado')
    expect(page).to_not have_content('Ruby')
    expect(page).to_not have_content('por R$ 10,00')
  end
end
