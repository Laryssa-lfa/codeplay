require 'rails_helper'

describe 'Admin view courses' do
  it 'successfully' do
    instructor = create(:instructor)
    create(:course, name: 'Ruby', description: 'Um curso de Ruby',
                    price: 10, instructor: instructor)
    create(:course, name: 'Ruby on Rails', instructor: instructor,
                    description: 'Um curso de Ruby on Rails', price: 20)

    user_login
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('R$ 20,00')
  end

  it 'and view details' do
    instructor = create(:instructor)
    course = create(:course, name: 'Ruby on Rails', instructor: instructor,
                             description: 'Um curso de Ruby on Rails', price: 20,
                             enrollment_deadline: '20/12/2033',
                             banner: fixture_file_upload(Rails.root.join('spec/fixtures/banner.png')))

    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_css('img[src*="banner.png"]')
    expect(page).to have_content('Maria')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content(course.code)
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')
  end

  it 'and no course is available' do
    user_login
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Nenhum curso disponível')
  end

  it 'and return to home page' do
    instructor = create(:instructor)
    create(:course, instructor: instructor)

    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    instructor = create(:instructor)
    create(:course, instructor: instructor)

    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Voltar'

    expect(current_path).to eq admin_courses_path
  end

  it 'must be logged in to view courses button' do
    visit root_path

    expect(page).to_not have_link('Cursos')
  end

  it 'must be logged in to view courses through route' do
    visit admin_courses_path

    expect(current_path).to eq(new_user_session_path)
  end

  it 'must be logged in to view courses detail through route' do
    instructor = create(:instructor)
    course = create(:course, instructor: instructor)

    visit admin_course_path(course)

    expect(current_path).to eq(new_user_session_path)
  end
end
