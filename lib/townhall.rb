require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_townhall_email(townhall_url)
	page = Nokogiri::HTML(open(townhall_url)) 
	email_array = []

	email = page.xpath('//*[contains(text(), "@")]').text
	town = page.xpath('//*[contains(text(), "Adresse mairie de")]').text.split 

	email_array << {town[3] => email} 
	puts email_array
	return email_array
end

def get_townhall_urls
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	url_array = []

	urls = page.xpath('//*[@class="lientxt"]/@href') 

	urls.each do |url| 
		url = "http://annuaire-des-mairies.com" + url.text[1..-1]
		url_array << url		
	end
	return url_array 
end


def scrapp_data
	url_array = get_townhall_urls 
	url_array.each do |townhall_url|
		get_townhall_email(townhall_url)
	end
end 

scrapp_data