require 'httparty'
require 'base64'
require 'digest/sha2'

module Tangerine
  module Backlot

    class HTTP
      include HTTParty
      base_uri 'http://api.ooyala.com/partner'
    end

    class API

      def self.authenticate!(credentials)
        @provider_code = credentials[:provider_code]
        @secret = credentials[:secret]
      end

      def self.get(request_type, params={})
        set_params(params)
        HTTP.get(request_type)
      end

      def self.set_params(params)
        HTTP.default_params.clear

        params['expires'] ||= (Time.now.to_i + 10).to_s
        HTTP.default_params params

        HTTP.default_params :pcode => @provider_code
        HTTP.default_params :signature => self.signature(params)
      end

      def self.signature(params)
        string_to_sign = params.keys.sort.inject(@secret) do |memo, key|
          memo += "#{key}=#{params[key]}"
        end
        digest = Digest::SHA256.digest(string_to_sign)
        Base64::encode64(digest).chomp.gsub(/=+$/, '')
      end

    end

  end

  def self.query(options)
    Tangerine::Backlot::API.get('/query', options)
  end
end

