require "open-uri"
require "csv"
require "nokogiri"
require "pry"

url = "https://www.mercari.com/jp/category/1/"
file = open(url)

doc = Nokogiri::HTML(file)
# binding.pry

doc.search(".items-box").each do |item|
  puts "*" * 100
  name = item.search(".items-box-name").text.strip
  price = item.search(".items-box-price").text.strip

  p name
end
