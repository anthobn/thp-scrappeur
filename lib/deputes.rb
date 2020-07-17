require 'nokogiri'
require 'open-uri'

def readPage(uri)
  #Read the page
  page = Nokogiri::HTML(open(uri))
  return page
end

def parse(page, uriPrefix)
  #find names and links of array page with all deputes.
  names = page.xpath('//tbody//a/text()')
  links = page.xpath('//tbody//a/@href')

  hash = {}
  i = 0
  names.each do |name|
    #work on uri to obtain the full url
    link = uriPrefix + links[i].to_s
    #add depute to hash
    hash[name.to_s] = link
    i += 1
  end
  return hash
end

def getEmail(uri)
  #get the email of depute webpage
  page = readPage(uri)
  email = page.xpath('//a[starts-with(@href, "mailto")]/text()')[1]
  return email
end

def perform(uri, uriPrefix)
  page = readPage(uri)
  hash_dep_uri = parse(page, uriPrefix)

  array = []
  hash_dep_uri.each do |key, value|
    puts "Traitement de : " + key
    email = getEmail(value)
    array << {key => email.to_s}
  end

  return array
  
end


#puts perform('http://www2.assemblee-nationale.fr/deputes/liste/tableau', 'http://www2.assemblee-nationale.fr')