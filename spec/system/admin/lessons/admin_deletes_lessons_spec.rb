require 'rails_helper'

describe 'Admin deletes lesson' do
  it 'successfully' do
    instructor = create(:instructor)
    course = create(:course, instructor: instructor)
    lesson = create(:lesson, course: course)

    user_login
    visit admin_course_path(course)
    click_on lesson.name
    expect { click_on 'Apagar Aula' }.to change { Lesson.count }.by(-1)

    expect(page).to have_text('Aula apagada com sucesso')
    expect(current_path).to eq(admin_course_path(course))
  end
end
