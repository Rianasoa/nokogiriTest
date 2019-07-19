require 'rubygems'
require 'nokogiri'
require 'open-uri'

#1 The page to scrapp
def get_page
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	return page
end 

#2 Take the abbreviations of name of the money
def scrapp_symbols
	page = get_page
	crypto_symbols = page.xpath('//*[@class="text-left col-symbol"]')
	crypto_symbols_array = [] #/ initiliaze the array for stocking all symbols
	crypto_symbols.each do |symbol| #/ put .text to be in string the symbols
		crypto_symbols_array << symbol.text 
	end
	return crypto_symbols_array
end

#3 Take the prices
def scrapp_prices
	page = get_page
	crypto_prices = page.xpath('//*[@class="price"]')
	crypto_prices_array = []
	crypto_prices.each do |price|
		crypto_prices_array << price.text[1..-1].to_f
	end
	return crypto_prices_array
end 

#4 Add togethterthe prices and the symbols
def crypto_master
	crypto_symbols_array = scrapp_symbols 
	crypto_prices_array = scrapp_prices 
	a = [] 

	crypto_symbols_array.each_with_index do |k, v|
		a << {k => (crypto_prices_array)[v]}
	end
	puts a
	return a
end
crypto_master