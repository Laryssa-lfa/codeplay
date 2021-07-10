require 'rails_helper'

describe 'Admin registers instructors' do
  it 'from index page' do
    visit instructors_path

    expect(page).to have_link('Registrar professor(a)',
                              href: new_instructor_path)
  end

  it 'successfully' do
    visit instructors_path
    click_on 'Registrar professor(a)'

    fill_in 'Nome', with: 'Maria'
    fill_in 'E-mail', with: 'maria@email.com'
    fill_in 'Descrição', with: 'Formada em Ciências da Computação e leciona há 9 anos'
    attach_file 'Foto de perfil', Rails.root.join('spec/fixtures/Maria.png')
    click_on 'Criar Professor(a)'

    expect(page).to have_content('Professor(a) registrado(a) com sucesso!')
    expect(page).to have_content('Maria')
    expect(page).to have_content('maria@email.com')
    expect(page).to have_content('Formada em Ciências da Computação e leciona há 9 anos')
    expect(page).to have_css('img[src*="Maria.png"]')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    visit instructors_path
    click_on 'Registrar professor(a)'

    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Criar Professor(a)'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and e-mail must be unique' do
    create(:instructor, email: 'jose@email.com')

    visit instructors_path
    click_on 'Registrar professor(a)'
    fill_in 'E-mail', with: 'jose@email.com'
    click_on 'Criar Professor(a)'

    expect(page).to have_content('já está em uso')
  end
end
