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