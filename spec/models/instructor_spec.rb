require 'rails_helper'

describe Instructor do
  it { should have_many(:courses) }
  it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
  it { should validate_presence_of(:email).with_message('não pode ficar em branco') }

  context 'display_name' do
    it 'should display name and email with hyphen' do
      instructor = Instructor.new(name: 'José',
                                  email: 'jose@email.com')
      expect(instructor.display_name).to eq('José - jose@email.com')
    end

    it 'should display name and email with multiple names' do
      instructor = Instructor.new(name: 'José Silva',
                                  email: 'jose@email.com')
      expect(instructor.display_name).to eq('José Silva - jose@email.com')
    end

    it 'should display even with empty values' do
      instructor = Instructor.new(name: '',
                                  email: 'jose@email.com')
      expect(instructor.display_name).to eq(' - jose@email.com')
    end
  end

  context 'validation' do
    it 'email must be uniq' do
      Instructor.create!(name: 'José', email: 'jose@email.com',
                         bio: "Formado em Sistema de Informação e leciona há 7 anos.")
      instructor = Instructor.new(email: 'jose@email.com')

      instructor.valid?

      expect(instructor.errors[:email]).to include('já está em uso')
    end
  end
end
