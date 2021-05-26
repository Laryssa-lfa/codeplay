require 'rails_helper'

describe 'admin updates courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com',
                                    bio: "Formada em Ciências da Computação e leciona há 9 anos.")
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    Instructor.create!(name: 'José', email: 'jose@email.com',
                       bio: "Formado em Sistema de Informação e leciona há 7 anos.")

    visit course_path(course)
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
end
