
RSpec.describe ShowCommand do

  describe "#result" do
    let(:name) {'rails'}
    subject(:command) { ShowCommand.new(name).result }

    it {is_expected.to be_a ShowCommand::ShowResult}

    context "with wrong gem name" do
      let(:name) {'ddsawd'}
      it {is_expected.to be_a InfoResult}
      
    end
  end

end
