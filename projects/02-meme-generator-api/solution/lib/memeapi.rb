require 'sinatra/base'
require './lib/download'
require 'pry'
require './lib/validators/meme_validator'
require './lib/image_creator'
require './lib/database/database'
require './lib/password_crypter'
require './lib/validators/login_validator'
require './lib/validators/signup_validator'
require './lib/token_generator'
require './lib/password_crypter'
require './lib/database/user'
require './lib/database/user_token'

class MemeApi < Sinatra::Application

  class << self
    def run
      run!
    end
  end

  post '/memes' do
    json_body = JSON.parse(request.body.read)
    MemeValidator.validate_image(json_body)
    image_path = Download.download_image(json_body['meme']['image_url'])
    image_name = ImageCreator.create_meme(image_path, json_body['meme']['text'])
    redirect "/memes/#{image_name}", 303
    rescue Download::Error => e
      status 404
    rescue MemeValidator::Error => e
      status 400
  end

  get '/memes/:file' do
    path = Pathname(__dir__).join("../images/#{params[:file]}")
    send_file(path)
  end

  post '/signup' do
    params = JSON.parse(request.body.read)
    SignupValidator.validate_account(params)
    user = create_user(params)
    database.insert_user(user)
    token = generate_token(user)
    database.insert_token(token)
    
    [201, {"user": {"token": token} }.to_json]
  rescue SignupValidator::ValidationError => e
    [400, {"errors": ["message": e.message]}.to_json]
  rescue Database::UserExistsError => e
    [409, {"errors": ["message": e.message]}.to_json]
  end

  post '/login' do
    params = JSON.parse(request.body.read)
    LoginValidator.validate_account(params)
    user = database.get_user(params['user']['username'])
    LoginValidator.validate_password(user.password, params['user']['password'])
    token = database.get_tokens(user.username)['token']

    [200, {"user": {"token": token } }.to_json]
  rescue LoginValidator::ValidationError => e
    [400, {"errors": ["message": e.message]}.to_json]
  rescue Database::NonExistentUserError => e
    [400, {"errors": ["message": e.message]}.to_json]
  rescue StandardError => e
    pp e
  end

  private

  def create_user(params)
    username = params['user']['username']
    password = params['user']['password']
    hashed_password = PasswordCrypter.encrypt(password)

    User.new(username, hashed_password)
  end

  def generate_token(user)
    UserToken.new(user, TokenGenerator.generate)
  end

  def database
    Database.create
  end
  
end
