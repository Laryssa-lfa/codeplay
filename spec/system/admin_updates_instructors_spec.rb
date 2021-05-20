require 'rails_helper'

describe 'Admin updates instructors' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com',
                                    bio: "Formada em Ciências da Computação e leciona há 9 anos.")

    visit instructor_path(instructor)
    click_on 'Editar'

    fill_in 'Descrição:', with: 'Formada em Ciências da Computação e leciona há 10 anos.'
    attach_file 'Foto de perfil:', Rails.root.join('spec/fixtures/Maria.png')
    click_on 'Salvar'

    expect(page).to have_text('Maria')
    expect(page).to have_text('maria@email.com')
    expect(page).to have_text('Formada em Ciências da Computação e leciona há 10 anos.')
    expect(page).to have_text('img[src*="Maria.png"]')
    expect(page).to have_text('Professor(a) atualizado(a) com sucesso!')
    expect(page).to have_text('Voltar')
  end
end
