require 'rails_helper'

describe 'Student view courses on homepage' do
  it 'courses with enrollment still available' do
    instructor = instructor = create(:instructor)
    available_course = create(:course, name: 'Ruby', price: 10, instructor: instructor)
    unavailable_course = create(:course, :expired, name: 'HTML', price: 20,
                                instructor: instructor)

    visit root_path

    expect(page).to have_content('Ruby')
    expect(page).to have_content(available_course.description)
    expect(page).to have_content('R$ 10,00')
    expect(page).not_to have_content('HTML')
    expect(page).not_to have_content('R$ 12,00')
  end

  it 'and view enrollment link' do
    instructor = create(:instructor)
    create(:course, name: 'Ruby', instructor: instructor)

    student_login
    visit root_path
    click_on 'Ruby'

    expect(page).to have_link 'Comprar'
  end

  it 'and does not view enrollment if deadline is over' do
    instructor = instructor = create(:instructor)
    available_course = create(:course, name: 'Ruby', price: 10, instructor: instructor)
    unavailable_course = create(:course, :expired, name: 'HTML', price: 12,
                                instructor: instructor, description: 'Um curso de HTML')

    student_login
    visit root_path

    expect(page).not_to have_link 'HTML'
    expect(page).not_to have_content 'Um curso de HTML'
    expect(page).not_to have_content 'R$ 12,00'
    expect(page).to have_link 'Ruby'
    expect(page).to have_content 'Um curso de Ruby'
    expect(page).to have_content 'R$ 10,00'
  end

  it 'must be signed in to enroll' do
    instructor = create(:instructor)
    create(:course, name: 'Ruby', instructor: instructor)

    visit root_path
    click_on 'Ruby'

    expect(page).not_to have_link 'Comprar'
    expect(page).to have_content 'Faça login para comprar este curso'
    expect(page).to have_link 'login', href: new_student_session_path
  end

  it 'and buy a course' do
    instructor = create(:instructor)
    create(:course, name: 'Ruby', price: 10, instructor: instructor)
    create(:course, name: 'Elixir', price: 12, instructor: instructor)

    student_login
    visit root_path
    click_on 'Ruby'
    click_on 'Comprar'

    expect(page).to have_content 'Curso comprado com sucesso'
    expect(current_path).to eq my_courses_courses_path
    expect(page).to have_content 'Ruby'
    expect(page).to have_content 'R$ 10,00'
    expect(page).not_to have_content 'Elixir'
    expect(page).not_to have_content 'R$ 20,00'
  end

  it 'and cannot buy a course twice' do
    student = student_login
    instructor = create(:instructor)
    available_course = create(:course, name: 'Ruby', instructor: instructor)
    create(:lesson, name: 'Monkey Patch', course: available_course)
    Enrollment.create!(student: student, course: available_course,
                       price: available_course.price)

    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link 'Comprar'
    expect(page).to have_link 'Monkey Patch'
  end
end
