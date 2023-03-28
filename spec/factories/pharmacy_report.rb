FactoryBot.define do
  factory :pharmacy_report do
    association :pharmacy
    association :report
    date_created { "令和４年１月１日" }
  end
end
