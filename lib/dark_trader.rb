require 'nokogiri'
require 'open-uri'

def readPage(uri)
  page = Nokogiri::HTML(open(uri))
  return page
end

def parseData(page)
  contentName = page.xpath('//tbody/tr/td[2]//a/text()')
  contentPrice = page.xpath('//tbody/tr/td[5]//a/text()')

  return contentName, contentPrice
end

def returnArrayofHash(contentName, contentPrice)
  array = []
  hash = {}
  i = 0

  contentName.each do |value|
    array << {value.to_s => contentPrice[i].to_s}
    i += 1
  end
  return array
end

def perform(uri)
  page = readPage(uri)
  contentName, contentPrice = parseData(page)
  return returnArrayofHash(contentName, contentPrice)
end

puts perform('https://coinmarketcap.com/all/views/all/')