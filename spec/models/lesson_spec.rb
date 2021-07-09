require 'rails_helper'

describe Lesson do
  it { should belong_to(:course) }
  it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:duration).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:content).with_message('não pode ficar em branco') }
  it { should validate_numericality_of(:duration).only_integer.is_greater_than(0) }

  context 'validation' do
    it 'code must be uniq' do
      instructor = create(:instructor)
      course = create(:course, instructor: instructor)
      create(:lesson, name: 'Classes e Objetos', course: course)
      lesson = Lesson.new(name: 'Classes e Objetos')

      lesson.valid?

      expect(lesson.errors[:name]).to include('já está em uso')
    end
  end
end
