require 'bcrypt'
class AccountValidator
  class ValidationError < StandardError
  end

  class << self
    def validate_account(body)
      expected_keys = %w[username password]
      if body.empty? || body['user'].keys.empty? ||((body['user'].keys & expected_keys).size != expected_keys.size) 
        raise AccountValidator::ValidationError.new('Bad request body')
      end
      raise AccountValidator::ValidationError.new('Username is blank') if body['user']['username'].empty?
      raise AccountValidator::ValidationError.new('Password is blank') if body['user']['password'].empty?
      true
    end
    def validate_password(hashed, password)
      return true if BCrypt::Password.new(hashed) == password
      
      raise AccountValidator::ValidationError.new('Wrong password, please try again.')
    end
  end
end
