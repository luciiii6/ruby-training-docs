require './lib/validators/signup_validator'

RSpec.describe SignupValidator do
  describe '.validate_account' do
    context 'validate request body for account' do
      let(:body) { JSON.parse('{
        "user": {
          "username": "mr_bean",
          "password": "test123"
        }
      }')
    }
      subject(:account_validation) { SignupValidator.validate_account(body) }

      it 'with good body request' do
        expect(account_validation).to eq true
      end
  
    end
    context 'with password empty body parameter' do
      let(:body) { JSON.parse('{
        "user": {
          "username": "mr_bean",
          "password": ""
        }
      }') }
      subject(:account_validation) { SignupValidator.validate_account(body) }

      it 'raises password empty error' do
        expect{ account_validation }.to raise_error(SignupValidator::ValidationError,'Password is blank')
      end
    end

    context 'with username empty body parameter' do
      let(:body) { JSON.parse('{
        "user": {
          "username": "",
          "password": "213215"
        }
      }') }
      subject(:account_validation) { SignupValidator.validate_account(body) }

      it 'raises username empty error' do
        expect{ account_validation }.to raise_error(SignupValidator::ValidationError,'Username is blank')
      end
    end
  end
end
