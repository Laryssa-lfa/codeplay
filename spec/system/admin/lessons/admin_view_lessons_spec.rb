require 'rails_helper'

describe 'Admin view lessons' do
  it 'of a course' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    other_course = Course.create!(name: 'Rails', description: 'Um curso de Ruby',
                                  code: 'RAILS', price: 10,
                                  enrollment_deadline: '22/12/2033', instructor: instructor)
    Lesson.create!(name: 'Classes e Objetos', duration: 10,
                   content: 'Uma aula de ruby', course: course)
    Lesson.create!(name: 'Monkey Patch', duration: 1,
                   content: 'Uma aula sobre Monkey Patch', course: course)
    Lesson.create!(name: 'Aula para não ver', duration: 40,
                   content: 'Uma aula sobre Monkey Patch', course: other_course)

    user_login
    visit admin_course_path(course)

    expect(page).to have_link('Classes e Objetos')
    expect(page).to have_text('10 minutos')
    expect(page).to have_link('Monkey Patch')
    expect(page).to have_text('1 minuto')
    expect(page).to_not have_text('Uma aula para não ver')
    expect(page).to_not have_text('40 minutos')
  end

  it 'and does not have lessons' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

    user_login
    visit admin_course_path(course)

    expect(page).to have_text('Não tem aulas cadastradas.')
  end
  
  it 'and view content' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    lesson = Lesson.create!(name: 'Classes e Objetos', duration: 10,
                            content: 'Uma aula de ruby', course: course)

    user_login
    visit admin_course_path(course)
    click_on lesson.name

    expect(page).to have_text(lesson.name)
    expect(page).to have_text(lesson.content)
    expect(page).to have_text("#{lesson.duration} minutos")
    expect(page).to have_link('Atualizar Aula')
    expect(page).to have_link('Apagar Aula')
    expect(page).to have_link('Voltar', href: admin_course_path(course))
  end

  it 'must be logged in to access through route' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033',
                            instructor: instructor)
    lesson = Lesson.create!(name: 'Classes e Objetos', duration: 10,
                            content: 'Uma aula de Ruby', course: course)

    visit admin_course_lesson_path(course, lesson)

    expect(current_path).to eq(new_user_session_path)
  end
end
