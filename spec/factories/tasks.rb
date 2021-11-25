FactoryBot.define do
  factory :task do
    name { FFaker::Lorem.characters(200) }
    completed { false }
    project
  end
end
