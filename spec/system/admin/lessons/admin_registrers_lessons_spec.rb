require 'rails_helper'

describe 'Admin registrers lessons' do
  it 'successfully' do
    instructor = create(:instructor)
    course = create(:course, instructor: instructor)
    
    user_login
    visit admin_course_path(course)
    click_on 'Registrar uma aula'
    fill_in 'Nome', with: 'Duck Typing'
    fill_in 'Duração', with: '10'
    fill_in 'Conteúdo', with: 'Uma aula sobre Duck Typing'
    click_on 'Criar'

    expect(page).to have_text('Duck Typing')
    expect(page).to have_text('10 minutos')
    expect(page).to have_text('Aula cadastrada com sucesso')
    expect(current_path).to eq(admin_course_path(course))
  end

  it 'and fill and fields' do
    instructor = create(:instructor)
    course = create(:course, instructor: instructor)
    
    user_login
    visit admin_course_path(course)
    click_on 'Registrar uma aula'
    click_on 'Criar Aula'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Duração não pode ficar em branco')
    expect(page).to have_text('Conteúdo não pode ficar em branco')
  end

  it 'must be logged in to create lesson' do
    instructor = create(:instructor)
    course = create(:course, instructor: instructor)

    visit new_admin_course_lesson_path(course)

    expect(current_path).to eq(new_user_session_path)
  end
end
