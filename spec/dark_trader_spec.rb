require_relative '../lib/dark_trader'

page = readPage('https://coinmarketcap.com/all/views/all/')

describe "crypto_scrapping" do

  it "must return crypto name examples" do
    expect(parseData(page).to_s).to include ('Bitcoin')
    expect(parseData(page).to_s).to include ('Ethereum')
    expect(parseData(page).to_s).to include ('Tether')
  end

  it 'must return array of hash like this [{"BITCOIN" => "$ XXX"}]' do
    contentName, contentPrice = parseData(page)
    expect(returnArrayofHash(contentName, contentPrice).to_s).to include ('Bitcoin')
    expect(returnArrayofHash(contentName, contentPrice).to_s).to include ('Ethereum')
    expect(returnArrayofHash(contentName, contentPrice).to_s).to include ('Tether')
    expect(returnArrayofHash(contentName, contentPrice).to_s).to include ('$')
  end

end