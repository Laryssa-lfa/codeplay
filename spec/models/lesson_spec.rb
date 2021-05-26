require 'rails_helper'

describe Lesson do
  it { should belong_to(:course) }
  it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:duration).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:content).with_message('não pode ficar em branco') }
  it { should validate_numericality_of(:duration).only_integer.is_greater_than(0) }

  context 'validation' do
    it 'code must be uniq' do
      instructor = Instructor.create!(name: 'Maria', email: 'maria@email.com')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 10,
                              enrollment_deadline: '22/12/2033', instructor: instructor)
      Lesson.create!(name: 'Classes e Objetos', duration: 10,
                     content: 'Uma aula de ruby', course: course)
      lesson = Lesson.new(name: 'Classes e Objetos')

      lesson.valid?

      expect(lesson.errors[:name]).to include('já está em uso')
    end
  end
end
