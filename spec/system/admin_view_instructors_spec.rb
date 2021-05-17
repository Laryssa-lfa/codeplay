require 'rails_helper'

describe 'Admin view instructor' do
  it 'successfully' do
    Instructor.create!(name: 'Maria', email: 'maria@email.com',
                   bio: "Formada em Ciências da Computação e leciona há 9 anos.")
    Instructor.create!(name: 'José', email: 'jose@email.com',
                   bio: "Formado em Sistema de Informação e leciona há 7 anos.")

    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Maria')
    expect(page).to have_content(attach_file 'profile_picture', './tmp/storage/Maria.png')
    expect(page).to have_content('José')
    expect(page).to have_content(attach_file 'profile_picture', './tmp/storage/José.png')
  end

  it 'and view details' do
    Instructor.create!(name: 'Maria', email: 'maria@email.com',
                   bio: "Formada em Ciências da Computação e leciona há 9 anos.")

    visit root_path
    click_on 'Professores'
    click_on 'Maria'

    expect(page).to have_content('Maria')
    expect(page).to have_content('maria@email.com')
    expect(page).to have_content('Formada em Ciências da Computação e leciona há 9 anos.')
    expect(page).to have_content(attach_file 'profile_picture', './tmp/storage/Maria.png')
  end

  it 'and no instructor is available' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum Professor cadastrado!')
  end

  it 'and return to home page' do
    Instructor.create!(name: 'Maria', email: 'maria@email.com',
                   bio: "Formada em Ciências da Computação e leciona há 9 anos.")

    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    Instructor.create!(name: 'Maria', email: 'maria@email.com',
                   bio: "Formada em Ciências da Computação e leciona há 9 anos.")
    Instructor.create!(name: 'José', email: 'jose@email.com',
                   bio: "Formado em Sistema de Informação e leciona há 7 anos.")

    visit root_path
    click_on 'Professores'
    click_on 'José'
    click_on 'Voltar'

    expect(current_path).to eq instructors_path
  end
end
