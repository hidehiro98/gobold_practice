require "open-uri"
require "csv"
require "nokogiri"
require "pry"

url = "https://www.mercari.com/jp/search/?sort_order=&keyword=%E3%82%A8%E3%83%AB%E3%83%A1%E3%82%B9&category_root=&brand_name=&brand_id=&size_group=&price_min=&price_max=&status_trading_sold_out=1"
file = open(url)

doc = Nokogiri::HTML(file)

doc.search(".items-box").each do |item|
  puts "*" * 100
  name = item.search(".items-box-name").text.strip
  price = item.search(".items-box-price").text.strip
  likes = item.search(".items-box-likes").text.strip
  item_url = item.css('a').attribute('href').value
  item_id = item_url.match(/m\d{11}/)[0]
  sold = item.search(".item-sold-out-badge").text.strip
  p name
  p price
  p likes
  p item_id
  p sold

  # binding.pry
  item_page = open(item_url)
  item_doc = Nokogiri::HTML(item_page)
  category = item_doc.css('tr')[1].css('a')[0].text.strip
  sub_category = item_doc.search('.item-detail-table-sub-category').text.strip
  user_url = item_doc.css('tr')[0].css('a').attribute('href').value
  p category
  p sub_category

  user_page = open(user_url)
  user_doc = Nokogiri::HTML(user_page)
  user_name = user_doc.search('.users-detail-title').text.strip
  user_score = user_doc.search('.users-detail-score').text.split(' ')[1]
  p user_name
  p user_score
  break
end
