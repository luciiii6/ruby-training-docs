require './lib/executable'
require './lib/show/show_command'

RSpec.describe Executable do

    subject {Executable.exec(argv)}
    let(:argv) { ['show', 'rspec'] }
    it "should return a ShowResult" do
        result = subject
        expect(result.name).to eq 'rspec'
        expect(result).to be_a(ShowCommand::ShowResult)
    end

end
