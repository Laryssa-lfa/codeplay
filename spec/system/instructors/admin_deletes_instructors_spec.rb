require 'rails_helper'

describe 'Admin deletes instructors' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'José', email: 'jose@email.com',
                                    bio: "Formado em Sistema de Informação e leciona há 7 anos.")

    visit instructor_path(instructor)
    expect { click_on 'Apagar' }.to change { Instructor.count }.by(-1)
    
    expect(page).to have_text('Professor(a) apagado com sucesso!')
    expect(current_path).to eq(instructors_path)
  end
end
