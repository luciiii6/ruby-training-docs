class SignupValidator
  class ValidationError < StandardError
  end

  class << self
    def validate_account(body)
      expected_keys = %w[username password]
      if body.empty? || body['user'].keys.empty? ||((body['user'].keys & expected_keys).size != expected_keys.size) 
        raise SignupValidator::ValidationError.new('Bad request body')
      end
      raise SignupValidator::ValidationError.new('Username is blank') if body['user']['username'].empty?
      raise SignupValidator::ValidationError.new('Password is blank') if body['user']['password'].empty?
      true
    end
  end
end
