FactoryBot.define do
  factory :user do
    email { FFaker::Internet.safe_email }
    password { SecureRandom.hex }
  end
end
