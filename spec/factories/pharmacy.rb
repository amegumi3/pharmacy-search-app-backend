FactoryBot.define do
  factory :pharmacy do
    name { "薬局名" }
    tel { "012-345-6789" }
    postal_code { "〒160-0014" }
    address { "新宿区内藤町１１" }
    shuttered { false }
    latitude { 35.685176 }
    longitude { 139.710052 }
  end
end
