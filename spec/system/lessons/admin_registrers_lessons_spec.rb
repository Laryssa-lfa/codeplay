require 'rails_helper'

describe 'Admin registrers lessons' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    
    visit course_path(course)
    click_on 'Registrar uma aula'
    fill_in 'Nome', with: 'Duck Typing'
    fill_in 'Duração', with: '10'
    fill_in 'Conteúdo', with: 'Uma aula sobre Duck Typing'
    click_on 'Criar'

    expect(page).to have_text('Duck Typing')
    expect(page).to have_text('10 minutos')
    expect(page).to have_text('Aula cadastrada com sucesso')
    expect(current_path).to eq(course_path(course))
  end

  it 'and fill and fields' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    Lesson.create!(name: 'Classes e Objetos', duration: 10,
                   content: 'Uma aula de ruby', course: course)
    
    visit course_path(course)
    click_on 'Classes e Objetos'
    click_on 'Atualizar Aula'
    fill_in 'Duração', with: '30'
    click_on 'Atualizar'

    expect(page).to have_text('Classes e Objetos')
    expect(page).to have_text('30 minutos')
    expect(page).to have_text('Aula atualizada com sucesso')
    expect(current_path).to eq(course_path(course))
  end
end
