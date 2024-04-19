require 'httparty'
require 'json'

def fetch_cryptocurrency_data
  url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"
  response = HTTParty.get(url)
  cryptocurrency_data = JSON.parse(response.body)
  cryptocurrency_data
end

def extract_cryptocurrency_info(cryptocurrency_data)
  cryptocurrency_info = []
  cryptocurrency_data.each do |crypto|
    name = crypto['name']
    price = crypto['current_price']
    market_cap = crypto['market_cap']
    cryptocurrency_info << { name: name, price: price, market_cap: market_cap }
  end
  cryptocurrency_info
end

def sort_by_market_cap(cryptocurrency_info)
  cryptocurrency_info.sort_by { |crypto| -crypto[:market_cap] }
end

def display_top_5_cryptocurrencies(cryptocurrency_info)
  puts "Top 5 Cryptocurrencies by Market Capitalization:"
  cryptocurrency_info[0, 5].each_with_index do |crypto, index|
    puts "#{index + 1}. #{crypto[:name]} - Price: $#{crypto[:price]} - Market Cap: $#{crypto[:market_cap]}"
  end
end

cryptocurrency_data = fetch_cryptocurrency_data
cryptocurrency_info = extract_cryptocurrency_info(cryptocurrency_data)
sorted_cryptocurrency_info = sort_by_market_cap(cryptocurrency_info)
display_top_5_cryptocurrencies(sorted_cryptocurrency_info)
