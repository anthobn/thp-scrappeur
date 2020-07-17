require_relative '../lib/deputes'

describe "list of deputes" do

  it "must return email of deputes" do
    expect(getEmail('http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA719146').to_s).to eq ('jean-felix.acquaviva@assemblee-nationale.fr')
    expect(getEmail('http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA608695').to_s).to eq ('cecile.untermaier@assemblee-nationale.fr')
  end

end