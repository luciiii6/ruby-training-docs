require "bcrypt"

class PasswordCrypter
  class WrongPasswordError < StandardError
  end

  class << self
    def encrypt(password)
      BCrypt::Password.create(password).to_s
    end
  end
end