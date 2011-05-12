require 'httparty'
require 'base64'
require 'digest/sha2'

module Tangerine
  module Backlot

    class NotAuthenticatedError < RuntimeError; end

    class HTTP
      include HTTParty
      base_uri 'http://api.ooyala.com/partner'
    end

    class API

      def self.authenticate!(credentials)
        creds = HashWithIndifferentAccess.new credentials
        @secret = creds[:secret]
        HTTP.default_params :pcode => creds[:provider_code]
      end

      def self.get(request_type, params={})
        raise NotAuthenticatedError unless self.authenticated?

        params['expires'] ||= (Time.now.to_i + 10).to_s
        params['signature'] = self.signature(params)
        HTTP.get(request_type, {:query => params})
      end

      def self.signature(params)
        string_to_sign = params.keys.sort.inject(@secret) do |memo, key|
          memo += "#{key}=#{params[key]}"
        end
        digest = Digest::SHA256.digest(string_to_sign)
        Base64::encode64(digest).chomp.gsub(/=+$/, '')
      end

      def self.authenticated?
        @secret && HTTP.default_params[:pcode]
      end

    end

  end

  def self.query(options)
    Tangerine::Backlot::API.get('/query', options)
  end
end

