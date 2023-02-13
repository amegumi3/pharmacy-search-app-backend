class Report < ApplicationRecord
  has_many :pharmacy_reports
  has_many :pharmacies, through: :pharmacy_reports
end
