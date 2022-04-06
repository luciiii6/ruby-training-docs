require './lib/search/search_options_parser'
RSpec.describe SearchOptionsParser do

  describe '.parse' do
    let(:args) {['rails', '--license', 'MIT']}
    subject(:command) { SearchOptionsParser.parse(args) }

    it{ is_expected.to be_a(Array) }
    
    it "first Array argument to be SearchOptionLicense" do
      expect(command[0]).to be_a SearchOptionLicense
    end

    it "first Array argument to be SearchOptionDownloads" do
      args = ['rails', '--most-downloads-first']
      command = SearchOptionsParser.parse(args)
      expect(command[0]).to be_a SearchOptionDownloads
    end

    it "Array to contain SearchOptionLicense and SearchOptionDownloads" do
      args = ['rails', '--most-downloads-first', '--license', 'MIT']
      commands = SearchOptionsParser.parse(args)
      expect(command.any?{|elem| elem.class == SearchOptionLicense}).to be true
      expect(command.any?{|elem| elem.class == SearchOptionLicense}).to be true
    end

    it "Array to be empty" do
      command = SearchOptionsParser.parse([])
      expect(command.empty?).to be true
    end

    it "Array to contain SearchOptionLicense and SearchOptionDownloads" do
      args = ['rails', '--most-downloads-first', '--license']
      commands = SearchOptionsParser.parse(args)
      expect(commands).to be_a StandardError
    end
  end
end
