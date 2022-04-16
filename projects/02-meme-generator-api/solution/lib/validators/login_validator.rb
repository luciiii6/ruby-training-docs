require 'bcrypt'
class LoginValidator
  class ValidationError < StandardError
  end

  class << self
    def validate_account(body)
      expected_keys = %w[username password]
      if body.empty? || body['user'].keys.empty? ||((body['user'].keys & expected_keys).size != expected_keys.size) 
        raise LoginValidator::ValidationError.new('Bad request body')
      end
      raise LoginValidator::ValidationError.new('Username is blank') if body['user']['username'].empty?
      raise LoginValidator::ValidationError.new('Password is blank') if body['user']['password'].empty?
      true
    end
    def validate_password(hashed, password)
      return true if BCrypt::Password.new(hashed) == password
      
      raise LoginValidator::ValidationError.new('Wrong password, please try again.')
    end
  end
end
