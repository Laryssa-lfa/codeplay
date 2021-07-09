require 'rails_helper'

describe 'admin updates lesson' do
  it 'successfully' do
    instructor = create(:instructor)
    course = create(:course, instructor: instructor)
    lesson = create(:lesson, course: course)

    user_login
    visit admin_course_lesson_path(course, lesson)
    click_on 'Atualizar Aula'
    fill_in 'Nome', with: 'Classes e Objetos'
    fill_in 'Duração', with: '20'
    click_on 'Atualizar Aula'

    expect(page).to have_text('Classes e Objetos')
    expect(page).to have_text('20 minutos')
    expect(page).to have_text('Aula atualizada com sucesso')
  end
end
