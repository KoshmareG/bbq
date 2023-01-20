FactoryBot.define do
  factory :user do
    name { "User_#{rand(999)}" }
    email { "mail_#{rand(999)}.@example.com" }
    after(:build) { |u| u.password_confirmation = u.password = 'Password123456' }
  end
end
