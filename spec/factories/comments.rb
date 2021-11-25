FactoryBot.define do
  factory :comment do
    name { FFaker::Lorem.words.join }
    task
  end
end
