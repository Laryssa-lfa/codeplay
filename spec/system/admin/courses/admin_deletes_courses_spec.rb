require 'rails_helper'

describe 'Admin deletes courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com',
                                    bio: "Formada em Ciências da Computação e leciona há 9 anos.")
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    
    user_login
    visit admin_course_path(course)
    expect { click_on 'Apagar Curso' }.to change { Course.count }.by(-1)

    expect(page).to have_text('Curso apagado com sucesso')
    expect(current_path).to eq(admin_courses_path)
  end

  it 'must be looged in to delete course' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

    visit admin_course_path(course)

    expect(current_path).to eq(new_user_session_path)
  end
end
