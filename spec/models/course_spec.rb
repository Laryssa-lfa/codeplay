require 'rails_helper'

describe Course do
  it { should have_many(:lessons) }
  it { should have_many(:enrollments) }
  it { should belong_to(:instructor) }

  context 'validation' do
    it 'attributes cannot be blank' do
      course = Course.new

      course.valid?

      expect(course.errors[:name]).to include('não pode ficar em branco')
      expect(course.errors[:code]).to include('não pode ficar em branco')
      expect(course.errors[:price]).to include('não pode ficar em branco')
    end

    it 'code must be uniq' do
      instructor = create(:instructor)
      create(:course, code: 'RUBYBASIC', instructor: instructor)
      course = Course.new(code: 'RUBYBASIC')

      course.valid?

      expect(course.errors[:code]).to include('já está em uso')
    end
  end
end
