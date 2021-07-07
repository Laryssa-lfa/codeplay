require 'rails_helper'

describe 'Admin view instructor' do
  it 'successfully' do
    Instructor.create!(name: 'Maria', email: 'maria@email.com',
                       bio: 'Formada em Ciências da Computação e leciona há 9 anos')
    Instructor.create!(name: 'José', email: 'jose@email.com',
                       bio: 'Formado em Sistema de Informação e leciona há 7 anos')

    user_login
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Maria')
    expect(page).to have_content('José')
  end

  it 'and view details' do
    Instructor.create!(name: 'Maria', email: 'maria@email.com',
                       bio: 'Formada em Ciências da Computação e leciona há 9 anos',
                       profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/Maria.png'))
    )

    user_login
    visit root_path
    click_on 'Professores'
    click_on 'Maria'

    expect(page).to have_content('Maria')
    expect(page).to have_content('maria@email.com')
    expect(page).to have_content('Formada em Ciências da Computação e leciona há 9 anos')
    expect(page).to have_css('img[src*="Maria.png"]')
  end

  it 'and no instructor is available' do
    user_login
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum Professor(a) registrado!')
  end

  it 'and return to home page' do
    user_login
    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    Instructor.create!(name: 'José', email: 'jose@email.com',
                       bio: 'Formado em Sistema de Informação e leciona há 7 anos')

    user_login
    visit root_path
    click_on 'Professores'
    click_on 'José'
    click_on 'Voltar'

    expect(current_path).to eq instructors_path
  end
end
