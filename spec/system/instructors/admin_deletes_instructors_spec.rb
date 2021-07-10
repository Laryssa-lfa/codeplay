require 'rails_helper'

describe 'Admin deletes instructors' do
  it 'successfully' do
    instructor = create(:instructor)

    visit instructor_path(instructor)
    expect { click_on 'Apagar' }.to change { Instructor.count }.by(-1)

    expect(page).to have_text('Professor(a) apagado(a) com sucesso!')
    expect(current_path).to eq(instructors_path)
  end
end
