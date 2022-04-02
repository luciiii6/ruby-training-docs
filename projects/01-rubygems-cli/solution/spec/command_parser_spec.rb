require './lib/command_parser'

RSpec.describe CommandParser do
  describe '.parse' do
    let(:argv) { %w[show rspec] }

    subject(:parse) { CommandParser.parse(argv) }

    it { is_expected.to be_a ShowCommand }

    context 'with no args' do
      let(:argv) { [] }

      it { is_expected.to be_a HelpCommand }
    end

    context 'with no gem name' do
      let(:argv) { ['show'] }

      it { is_expected.to be_a HelpShowCommand }
    end

    context 'with unknown command' do
      let(:argv) { %w[cook beef] }

      it { is_expected.to be_a HelpCommand }
    end
  end
end
