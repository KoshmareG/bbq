FactoryBot.define do
  factory :event do
    title { "Event_#{rand(999)}" }
    description { "description_#{rand(999)}" }
    address { "address_#{rand(999)}" }
    datetime { "#{rand(1..31)} Dec #{rand(2022)} 10:00:00" }
  end
end
