class Pharmacy < ApplicationRecord
  require 'uri'
  require "net/http"
  require 'json'
  require 'rexml/document'
  
  YAHOO_API_KEY = ENV["API_KEY"]
  geocoded_by :address


  def self.import(file)
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
      adress = row[3].value[9..-1]
      pharmacy = create(number: i, name: row[2].value, adress: adress, postal_code: postal_code, tel: row[4].value)

      # 緯度経度取得
      query = URI.encode_www_form(query: pharmacy.adress)
      search_url =  "https://map.yahooapis.jp/geocode/V1/geoCoder?appid=" + YAHOO_API_KEY
      search_url += query
      res = URI.parse(search_url)
      xml = Net::HTTP.get(res)
      doc = REXML::Document.new(xml)
      hash = Hash.from_xml(doc.to_s)
      next if hash["YDF"]["Feature"].nil?
      if !hash["YDF"]["Feature"][0].nil?
        geocode = hash["YDF"]["Feature"][0]["Geometry"]["Coordinates"]
      elsif !hash["YDF"]["Feature"]["Geometry"].nil?
        geocode = hash["YDF"]["Feature"]["Geometry"]["Coordinates"]
      end
      lon, lat = geocode.split(",")
      pharmacy.update(latitude: lat.to_f, longitude: lon.to_f)
    end
    Pharmacy.update(number: nil)
  end
end
