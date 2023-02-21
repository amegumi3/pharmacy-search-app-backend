FactoryBot.define do
  factory :report do
    name { "在宅患者調剤加算" }
    point { "１５点" }
    basic { false }
    report_feature { "在宅業務に十分に対応している" }
    calc_case { "在宅患者訪問薬剤管理指導 料を算定している患者その他厚生労働大臣が定める患者に対する調剤を行った場合" }
  end
end
