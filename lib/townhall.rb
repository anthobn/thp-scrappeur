require 'nokogiri'
require 'open-uri'

def readPage(uri)
  #Read the page
  page = Nokogiri::HTML(open(uri))
  return page
end

def get_townhall_email(page)
  #return email data from the web page of townhall
  begin
    email = page.xpath('//table/tbody/tr[4]/td[2]/text()').first
  rescue => exception
    puts "Erreur lors de la récupération de l'adresse email"
  end
  return email
end

def get_townhall_urls(uri)
  #return all uri of townhall by department
  page = readPage(uri)
  uri_townhall = page.xpath('//a[@class="lientxt"]/@href')
  name_townhall = page.xpath('//a[@class="lientxt"]/text()')

  hash = {}
  i = 0

  #create full uri
  uri = uri.split('/')
  uri = uri[0..-2].join('/')

  uri_townhall.each do |value|
    value = uri + (value.to_s)[1..-1]
    #add to hash the uri
    hash[(name_townhall[i]).to_s] = value
    i += 1
  end
  return hash
end

def perform(uri)
  #get the uri of townall by department
  townhall_name_uri_hash = get_townhall_urls(uri)

  array = []
  hash = {}
  townhall_name_uri_hash.each do |key, value|
    puts 'Traitement de : ' + key
    page = readPage(value)
    email = get_townhall_email(page)
    #add to array the hash of {townhall => email}
    array << {key => email.to_s}
  end

  return array
end

#puts "Le traitement est en cours, cela peut prendre un moment..."
#puts perform('https://www.annuaire-des-mairies.com/val-d-oise.html')
#puts perform('https://www.annuaire-des-mairies.com/var.html')