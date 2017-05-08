require "open-uri"
require "csv"
require "nokogiri"
require "pry"

url = "https://www.mercari.com/jp/category/1/"
file = open(url)

doc = Nokogiri::HTML(file)

doc.search(".items-box").each do |item|
  puts "*" * 100
  name = item.search(".items-box-name").text.strip
  price = item.search(".items-box-price").text.strip
  likes = item.search(".items-box-likes").text.strip
  p name
  p price
  p likes

  # binding.pry
  item_url = item.css('a').attribute('href').value
  item_page = open(item_url)
  item_doc = Nokogiri::HTML(item_page)
  sub_category = item_doc.search('item-detail-table-sub-category').text.strip
  p sub_category
end
