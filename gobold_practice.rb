require "open-uri"
require "csv"
require "nokogiri"
require "pry"

url = "https://www.mercari.com/jp/category/861/"
file = open(url)

doc = Nokogiri::HTML(file)

doc.search(".items-box").each do |item|
  puts "*" * 100
  name = item.search(".items-box-name").text.strip
  price = item.search(".items-box-price").text.strip
  likes = item.search(".items-box-likes").text.strip
  item_url = item.css('a').attribute('href').value
  item_id = item_url.match(/m\d{11}/)[0]
  p name
  p price
  p likes
  p item_id

  # binding.pry
  item_page = open(item_url)
  item_doc = Nokogiri::HTML(item_page)
  category = item_doc.css('tr')[1].css('a')[0].text.strip
  sub_category = item_doc.search('.item-detail-table-sub-category').text.strip
  p category
  p sub_category
  break
end
