require 'rails_helper'

describe 'User authentication' do
  it 'cannot access create without login' do
    post admin_courses_path, params: { course: { name:'Ruby' } }

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'cannot delete without login' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com',
                                    bio: "Formada em Ciências da Computação e leciona há 9 anos.")
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    delete admin_course_path(course)

    expect(response).to redirect_to(new_user_session_path)
  end
end
