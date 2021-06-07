require 'rails_helper'

describe 'Admin registers courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com',
                                    bio: "Formada em Ciências da Computação e leciona há 9 anos.")

    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: '22/12/2033'
    select "#{instructor.name} - #{instructor.email}", from: 'Instrutor(a)'
    attach_file 'Banner', Rails.root.join('spec/fixtures/banner.png')
    click_on 'Criar Curso'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('Maria - maria@email.com')
    expect(page).to have_css('img[src*="banner.png"]')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'
    click_on 'Criar Curso'

    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('Instrutor(a) é obrigatório(a)')
  end

  it 'and code must be unique' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com',
                                    bio: "Formada em Ciências da Computação e leciona há 9 anos.")
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Registrar um Curso'
    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Criar Curso'

    expect(page).to have_content('já está em uso')
  end

  it 'must be looged in to create course' do
    visit new_admin_course_path

    expect(current_path).to eq(new_user_session_path)
  end
end
