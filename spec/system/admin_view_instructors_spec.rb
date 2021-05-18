require 'rails_helper'

#Issues 6 - Ver professores

describe 'Admin view instructor' do
  it 'successfully' do
    Instructor.create!(name: 'Maria', email: 'maria@email.com',
                   bio: "Formada em Ciências da Computação e leciona há 9 anos.")
    Instructor.create!(name: 'José', email: 'jose@email.com',
                   bio: "Formado em Sistema de Informação e leciona há 7 anos.")
    
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Maria')
    expect(page).to have_content('José')
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
  end

  it 'and no instructor is available' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum Professor cadastrado!')
  end

  it 'and return to home page' do

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
