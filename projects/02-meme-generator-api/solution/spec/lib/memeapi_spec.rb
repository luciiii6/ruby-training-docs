require './lib/memeapi'
require './lib/database/database'

RSpec.describe MemeApi do
  
  def app
    MemeApi 
  end

  describe "POST /memes" do
    context 'with good body request' do
      it "returns status 303 and redirect link" do
        body = {
          "meme": {
            "image_url": "https://s3.amazonaws.com/com.twilio.prod.twilio-docs/images/test.original.jpg",
            "text": "You got Rick-rolled"
          }
        }

        post '/memes', body.to_json, { 'CONTENT_TYPE' => 'application/json' }

        expect(last_response.status).to eq 303
        expect(last_response.location).to eq 'http://example.org/memes/test.original.jpg'
      end
    end

    context 'with bad link for download' do
      it "returns status 404 for failed download" do
        body = {
          "meme": {
            "image_url": "dsadkaskdjaskjdasdaskdjasjkd",
            "text": "You got Rick-rolled"
          }
        }

        post '/memes', body.to_json, { 'CONTENT_TYPE' => 'application/json' }
        expect(last_response.status).to eq 404
      end
    end
    context 'with bad body request' do
      it "returns status 400 for missing keys in body" do
        body = {
          "meme":{
            "image_url": "https://s3.amazonaws.com/com.twilio.prod.twilio-docs/images/test.original.jpg"
          }
        }

        post '/memes', body.to_json, { 'CONTENT_TYPE' => 'application/json' }
        expect(last_response.status).to eq 400
      end

      it "returns status 400 for empty body" do
        post '/memes', '{}', { 'CONTENT_TYPE' => 'application/json' }
        expect(last_response.status).to eq 400
      end
    end
  end

  describe "POST /signup" do
    context 'with good body request' do
      it "returns status 201" do
        body = {
          "user": {
            "username": "mr_bean",
            "password": "test123"
          }
        }
        post '/signup', body.to_json, { 'CONTENT_TYPE' => 'application/json' }

        expect(last_response.status).to eq 201
      end

      it "returns status 201" do
        body = {
          "user": {
            "username": "mr_bean",
            "password": "test123"
          }
        }
        post '/signup', body.to_json, { 'CONTENT_TYPE' => 'application/json' }

        expect(last_response.status).to eq 400
      end
    end

  context 'with bad body request' do
    it "returns status 400" do
      body = { "user": {}}
      post '/signup', body.to_json, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq 400
    end
  end

  context 'with empty username request' do
    it 'returns status 400 and message is "Username is blank"' do
      body = {
        "user": {
          "username": "",
          "password": "test123"
        }
      }
      post '/signup', body.to_json, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq 400
      expect(JSON.parse(last_response.body)["errors"][0]["message"]).to eq "Username is blank"
    end
  end

  context 'with empty password request' do
    it 'returns status 400 and message is "Password is blank"' do
      body = {
        "user": {
          "username": "mr_bean",
          "password": ""
        }
      }
      post '/signup', body.to_json, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq 400
      expect(JSON.parse(last_response.body)["errors"][0]["message"]).to eq "Password is blank"
    end
  end
  end

  describe "POST /login" do  
    context 'request with good credentials' do
      it "returns status 201 and the a token" do
        body = {
          "user": {
            "username": "mr_bean",
            "password": "test123"
          }
        }
        post '/login', body.to_json, { 'CONTENT_TYPE' => 'application/json' }

        expect(last_response.status).to eq 201
      end

      context 'request with wrong password' do
        it 'returns status 400 and message "Wrong password, please try again."' do
          body = {
            "user": {
              "username": "mr_bean",
              "password": "testw2dsadw131"
            }
          }
          post '/login', body.to_json, { 'CONTENT_TYPE' => 'application/json' }
  
          expect(last_response.status).to eq 400
          expect(JSON.parse(last_response.body)["errors"][0]["message"]).to eq 'Wrong password, please try again.'
        end
      end

      context 'request with non existent username' do
        it 'returns status 400 and message "This username does not exist."' do
          body = {
            "user": {
              "username": "mr_dwdsadwbean",
              "password": "desw"
            }
          }
          post '/login', body.to_json, { 'CONTENT_TYPE' => 'application/json' }
  
          expect(last_response.status).to eq 400
          expect(JSON.parse(last_response.body)["errors"][0]["message"]).to eq 'This username does not exist.'

        end
      end
  end
end

  describe "GET" do          
      it "returns an image type" do
        get "/memes/test.original.jpg"
        expect(last_response.content_type).to eq 'image/jpeg'
      end
  end



  after(:suite) do
    Database.create.delete_users
  end
end