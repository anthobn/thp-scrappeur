require_relative '../lib/townhall'

page1 = readPage('https://www.annuaire-des-mairies.com/95/longuesse.html')
page2 = readPage('https://www.annuaire-des-mairies.com/95/ableiges.html')

describe "directory of townhall" do

  it "must return email of townhall" do
    expect(get_townhall_email(page1).to_s).to eq ('mairie.longuesse@orange.fr')
    expect(get_townhall_email(page2).to_s).to eq ('mairie.ableiges95@wanadoo.fr')
  end

  it "must return array of URI" do
    expect(get_townhall_urls('http://annuaire-des-mairies.com/var.html').to_s).to include ('FREJUS')
    expect(get_townhall_urls('http://annuaire-des-mairies.com/alpes-maritimes.html').to_s).to include ('NICE')
  end

end