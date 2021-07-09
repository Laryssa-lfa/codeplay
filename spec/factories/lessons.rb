FactoryBot.define do
  factory :lesson do
    name { ['Clases e Objetos', 'Monkey Patch'].sample }
    duration { rand(1..10) }
    content { 'Uma aula de Ruby' }
    course
  end
end
