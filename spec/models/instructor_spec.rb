require 'rails_helper'

describe Instructor do
  context 'validation' do
    it 'attributes cannot be blank' do
      instructor = Instructor.new

      instructor.valid?

      expect(instructor.errors[:name]).to include('está em branco, por favor preencher.')
      expect(instructor.errors[:email]).to include('está em branco, por favor preencher.')
    end

    it 'email must be uniq' do
      Instructor.create!(name: 'José', email: 'jose@email.com',
                         bio: "Formado em Sistema de Informação e leciona há 7 anos.")
      instructor = Instructor.new(email: 'jose@email.com')

      instructor.valid?

      expect(instructor.errors[:email]).to include('já em uso!')
    end
  end
end
