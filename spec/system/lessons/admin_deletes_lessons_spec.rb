require 'rails_helper'

describe 'Admin deletes lesson' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com',
                                    bio: "Formada em Ciências da Computação e leciona há 9 anos.")
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    Lesson.create!(name: 'Classes e Objetos', duration: 10,
                   content: 'Uma aula de ruby', course: course)
    lesson = Lesson.create!(name: 'Monkey Patch', duration: 1,
                            content: 'Uma aula sobre Monkey Patch', course: course)
    
    visit course_path(course)
    click_on lesson.name
    expect { click_on 'Apagar Aula' }.to change { Lesson.count }.by(-1)

    expect(page).to have_text('Aula apagada com sucesso')
    expect(current_path).to eq(course_path(course))
  end
end
