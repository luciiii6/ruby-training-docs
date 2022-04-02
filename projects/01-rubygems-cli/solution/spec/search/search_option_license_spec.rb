require './lib/search/search_option_license'

RSpec.describe SearchOptionLicense do
  let(:results) { [{'licenses'=> ['']}, {'licenses' => 'MIT'}] }
  subject(:result) { SearchOptionLicense.new('MIT').apply(results) }

  describe '#apply' do
    it "size of returning Array to be 1" do 
      expect(result.size).to eq 1
    end
    it "first element to contain MIT" do 
      expect(result[0]['licenses'].include?('MIT')).to be true
    end
  end
end
