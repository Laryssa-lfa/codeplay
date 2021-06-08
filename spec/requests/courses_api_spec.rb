require 'rails_helper'

describe 'Courses API' do
  context 'GET /api/v1/courses' do
    it 'should get courses' do
      instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                    code: 'RUBYBASIC', price: 10,
                    enrollment_deadline: '22/12/2033', instructor: instructor)
      Course.create!(name: 'Ruby on Rails',
                    description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', price: 20,
                    enrollment_deadline: '20/12/2033', instructor: instructor,
                    banner: fixture_file_upload(Rails.root.join('spec/fixtures/banner.png')))

      get '/api/v1/courses'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(Course.count)
      expect(parsed_body[0]['name']).to eq('Ruby')
      expect(parsed_body[1]['name']).to eq('Ruby on Rails')
    end

    it 'returns no courses' do
      get '/api/v1/courses'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/courses/:code' do
    it 'should return a course' do
      instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                    code: 'RUBYBASIC', price: 10,
                    enrollment_deadline: '22/12/2033', instructor: instructor)
      Course.create!(name: 'Ruby on Rails',
                    description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', price: 20,
                    enrollment_deadline: '20/12/2033', instructor: instructor,
                    banner: fixture_file_upload(Rails.root.join('spec/fixtures/banner.png')))

      get "/api/v1/courses/#{course.code}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('Ruby')
      expect(response.body).to include('RUBYBASIC')
      expect(response.body).to include('Um curso de Ruby')
      expect(response.body).to include('10.0')
      expect(response.body).not_to include('RUBYONRAILS')
    end

    it ' should not found course by code' do
      get '/api/v1/courses/ABC1234'

      expect(response).to have_http_status(404)
    end
  end

  context 'POST /api/v1/courses' do
    it 'should creat a courses' do
      instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')

      post '/api/v1/courses', params: {
        course: { name: 'Ruby on Rails', code: 'RUBYONRAILS', price: 10,
                  instructor_id: instructor.id }
      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Ruby on Rails')
      expect(parsed_body['code']).to eq('RUBYONRAILS')
      expect(parsed_body['price']).to eq('10.0')
    end

    it 'should not creat a course with invalid params' do
      post '/api/v1/courses', params: { course: { number: 10 } }

      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq(['não pode ficar em branco'])
      expect(parsed_body['code']).to include('não pode ficar em branco')
      expect(parsed_body['price']).to eq(['não pode ficar em branco'])
      expect(parsed_body['instructor']).to eq(['é obrigatório(a)'])
    end

    it 'code must be unique' do
      instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 10,
                              enrollment_deadline: '22/12/2033', instructor: instructor)

      post '/api/v1/courses', params: {
        course: { name: 'Ruby on Rails', code: 'RUBYBASIC', price: 10,
                  instructor_id: instructor.id }
      }

      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['code']).to eq(['já está em uso'])
    end

    it 'should not creat a course with invalid parameters' do
      post '/api/v1/courses'

      expect(response).to have_http_status(412)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('parâmetros inválidos')
    end
  end

  context 'PATCH /api/v1/courses' do
    it 'should update a courses' do
      instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 10,
                              enrollment_deadline: '22/12/2033', instructor: instructor)

      patch "/api/v1/courses/#{course.code}", params: { course: { price: 20 } }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Ruby')
      expect(parsed_body['code']).to eq('RUBYBASIC')
      expect(parsed_body['price']).to eq('20.0')
    end
  end

  context 'DELETE /api/v1/courses' do
    it 'should delete a courses' do
      instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 10,
                              enrollment_deadline: '22/12/2033', instructor: instructor)

      delete "/api/v1/courses/#{course.code}"

      expect(response).to have_http_status(200)
    end
  end

  private

  def parsed_body
    JSON.parse(response.body)
  end
end
