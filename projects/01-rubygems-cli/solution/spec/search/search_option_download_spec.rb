require './lib/search/search_option_downloads'

RSpec.describe SearchOptionDownloads do
  let(:results) { [{'downloads'=> '20112'}, {'downloads' => '123124521'}] }
  subject(:result) { SearchOptionDownloads.new.apply(results) }

  describe '#apply' do
    it "See result is different from input" do 
      expect(result).not_to eq results
    end

    
    it "See result is the same as input" do 
      results = [{'downloads'=> '123124521'}, {'downloads' => '20112'}]
      result = SearchOptionDownloads.new.apply(results)
      expect(result).to eq results
    end

  end
end