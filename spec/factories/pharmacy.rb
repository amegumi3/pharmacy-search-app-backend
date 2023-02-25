FactoryBot.define do
  factory :pharmacy do
    name { "Test Pharmacy" }
    tel { "012-123-4556" }
    postal_code { "〒111-1111" }
    adress { "千葉県浦安市舞浜１−１" }
    shuttered { false }
    latitude { "35.632896" }
    longitude { "139.8803944" }
  end
end
