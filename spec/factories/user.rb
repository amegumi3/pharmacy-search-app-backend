FactoryBot.define do
  factory :user do
    name { "Test Name" }
    email { "test@testmail.com" }
    password { "password" }
  end
end
