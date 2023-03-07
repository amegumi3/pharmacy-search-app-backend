class Pharmacy < ApplicationRecord
  require 'uri'
  require "net/http"
  require 'json'

  has_many :pharmacy_reports, dependent: :destroy
  has_many :reports, through: :pharmacy_reports

  YAHOO_API_KEY = ENV["API_KEY"]
  geocoded_by :address

  def self.pharmacy_import(file)
    i = 0
    xlsx = Roo::Excelx.new(file.tempfile)
    xlsx.each_row_streaming(offset: 10) do |row|
      i += 1
      if row[9].value == "休止"
        pharmacy = Pharmacy.find_by(number: i - 1)
        pharmacy.shuttered = true
        pharmacy.save
      end
      next if row[0].blank?
      postal_code = row[3].value[0..8]
      address = row[3].value[9..-1]
      pharmacy = create(number: i, name: row[2].value, address: address, postal_code: postal_code, tel: row[4].value)

      # 緯度経度取得
      query = URI.encode_www_form(query: pharmacy.address)
      search_url =  "https://map.yahooapis.jp/geocode/V1/geoCoder?appid=" + YAHOO_API_KEY + "&output=json&"
      search_url += query
      uri = URI.parse(search_url)
      res = Net::HTTP.get(uri)
      data = JSON.parse(res)
      next if data["ResultInfo"]["Count"] != 1
      geocode = data["Feature"][0]["Geometry"]["Coordinates"]
      lon, lat = geocode.split(",")
      pharmacy.update(latitude: lat.to_f, longitude: lon.to_f)
    end
    Pharmacy.update(number: nil)
  end
end
