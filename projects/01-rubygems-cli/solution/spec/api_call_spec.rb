require './lib/api_call'

RSpec.describe ApiCall do

  describe '.show' do
    let(:name) {'rails'}
    subject(:api_result) { ApiCall.show(name) }

    it {is_expected.to be_a(Success)}

    it 'returns json as payload' do
      expect(api_result.data).to be_a(Hash)
    end

    context 'return Failure because of wrong name of gem' do
      let(:name) {'gsgws'}
      it {is_expected.to be_a(Failure)}

      it 'returns a one key Hash' do
        expect(api_result.data.length()).to eq 1
      end
    end
  end

  describe '.search' do
    let(:query) {'rails'}
    subject(:api_result) {ApiCall.search(query)}

    it {is_expected.to be_a(Success)}

    it 'returns an array' do
      expect(api_result.data).to be_a(Array)
    end
  end

end