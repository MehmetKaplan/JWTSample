# JWTSample

1. Insert gem into Gemfile and intall it.

    ```ruby
    gem 'jwt'
    ```
    ```ruby
    bundle install
    ```
2. Generate file ```lib/json_web_token.rb``` with following class:

    ```ruby
    class JsonWebToken
        def self.encode(payload)
            JWT.encode(payload, Rails.application.secrets.secret_key_base)
        end

        def self.decode(token)
            return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
        rescue
            nil
        end

    end
    ```

3. For test purposes generate the routes and the controller:

    ```config/routes.rb```:
    ```ruby
    Rails.application.routes.draw do
        # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
        get 'JWTTest/encode/:data', to: 'JWTTest#encode'
        get 'JWTTest/encode/:data', to: 'JWTTest#decode'
    end
    ```
    ```config/JWT_test_controller.rb```:
    ```ruby
    require 'json_web_token' # don't forget incldue
    include ActionView::Helpers::TextHelper

    class JwtCheckController < ApplicationController
        def encode
            render :text => "encoded output: " + JsonWebToken.encode(request[:data])
        end
        def decode
            render :text => "decoded output: <br>" + 
                    "The full array returned: " + JsonWebToken.decode(request[:data]).to_s + "<br>" +
                    "Payload: " + JsonWebToken.decode(request[:data])[0].to_s + "<br>" +
                    "Header: " + JsonWebToken.decode(request[:data])[1].to_s + "<br>" +
                    JsonWebToken.decode(request[:data])[2].to_s + "<br>" 
                    #[0] + "\n"
        end
    end
    ```

4. To use:

    Call following url to embed the text ```text that is to be protected```.
    ```url
    http://localhost:3000/JWTCheck/encode/the text that is to be protected
    ```
    You should see the encrypted data like (but the encoded data must be different):
    ```text
    encoded output: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.InRoZSB0ZXh0IHRoYXQgaXMgdG8gYmUgcHJvdGVjdGVkIg.Cmqqtxmjy7CuWUqIq8YTnvwxEDdrJhgrSXchiG5PPh8
    ```
    Using this encoded data, to decrypt call:
    ```url
    http://localhost:3000/JWTCheck/decode/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.InRoZSB0ZXh0IHRoYXQgaXMgdG8gYmUgcHJvdGVjdGVkIg.Cmqqtxmjy7CuWUqIq8YTnvwxEDdrJhgrSXchiG5PPh8
    ```
    Now you must recover your message (or the "claim") which is ```the text that is to be protected```:
    ```text
    decoded output: 
    The full array returned: ["the text that is to be protected", {"typ"=>"JWT", "alg"=>"HS256"}]
    Payload: the text that is to be protected
    Header: {"typ"=>"JWT", "alg"=>"HS256"}
    ```

