require 'rails_helper'

describe 'Student view lesson' do
  it 'successfully' do
    user = User.create!(email: 'jane@test.com.br', password: '123456')
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    available_course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', price: 10,
                                      enrollment_deadline: 1.month.from_now, instructor: instructor)
    Lesson.create!(name: 'Monkey Patch', course: available_course, duration: 20,
                   content: 'Uma aula legal')
    Enrollment.create!(user: user, course: available_course)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'
           
    expect(page).to_not have_link 'Comprar'
    expect(page).to have_link 'Monkey Patch'
    expect(page).to have_content '20 minutos'
  end

  it 'without enrollment cannot view lesson link' do
    user = User.create!(email: 'jane@test.com.br', password: '123456')
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    available_course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', price: 10,
                                      enrollment_deadline: 1.month.from_now, instructor: instructor)
    Lesson.create!(name: 'Monkey Patch', course: available_course, duration: 20,
                   content: 'Uma aula legal')
    
    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'
           
    expect(page).to have_link 'Comprar'
    expect(page).to have_content 'Monkey Patch'
    expect(page).not_to have_link 'Monkey Patch'
  end

  it 'without login cannot view lesson' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, instructor: instructor)
    lesson = Lesson.create!(name: 'Monkey Patch', course: course, duration: 20,
                            content: 'Uma aula legal')

    visit course_lesson_path(course, lesson)

    expect(current_path).to eq(new_user_session_path)
  end

  it 'without enrollment cannot view lesson' do
    user = User.create!(email: 'jane@test.com.br', password: '123456')
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, instructor: instructor)
    lesson = Lesson.create!(name: 'Monkey Patch', course: course, duration: 20,
                            content: 'Uma aula legal')

    login_as user, scope: :user
    visit course_lesson_path(course, lesson)

    expect(current_path).to eq(course_path(course))
    expect(page).to have_link 'Comprar'
  end
end
