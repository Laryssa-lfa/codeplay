require 'rails_helper'

describe 'admin updates lesson' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com',
                                    bio: "Formada em Ciências da Computação e leciona há 9 anos.")
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    lesson = Lesson.create!(name: 'Classes e Objetos', duration: 10,
                            content: 'Uma aula de ruby', course: course)

    visit course_lesson_path(course, lesson)
    click_on 'Atualizar Aula'
    fill_in 'Nome', with: 'Classes e Objetos'
    fill_in 'Duração', with: '20'
    click_on 'Atualizar Aula'

    expect(page).to have_text('Classes e Objetos')
    expect(page).to have_text('20 minutos')
    expect(page).to have_text('Aula atualizada com sucesso')
  end
end
