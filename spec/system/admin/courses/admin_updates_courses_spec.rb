require 'rails_helper'

describe 'admin updates courses' do
  it 'successfully' do
    instructor = create(:instructor)
    create(:instructor, name: 'João', email: 'joao@email.com')
    course = create(:course, instructor: instructor)
                       
    user_login
    visit admin_course_path(course)
    click_on 'Editar Curso'
    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de RoR'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: '30/11/2033'
    select 'Maria - maria@email.com', from: 'Instrutor(a)'
    click_on 'Atualizar Curso'

    expect(page).to have_text('Ruby on Rails')
    expect(page).to have_text('Um curso de RoR')
    expect(page).to have_text('RUBYONRAILS')
    expect(page).to have_text('R$ 30,00')
    expect(page).to have_text('30/11/2033')
    expect(page).to have_text('Curso atualizado com sucesso')
    expect(page).to have_text('Maria - maria@email.com')
  end

  it 'must be looged in to update course' do
    instructor = create(:instructor)
    course = create(:course, instructor: instructor)

    visit edit_admin_course_path(course)

    expect(current_path).to eq(new_user_session_path)
  end
end
