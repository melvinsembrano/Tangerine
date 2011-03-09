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
        HTTP.default_params :signature => self.signature(params)
        HTTP.default_params :pcode => @provider_code
        HTTP.get(request_type)
      end

      # TODO: Refactor this method since it's doing double-duty ... not sure why Ooyala API doesn't like
      # it if we assign some values to params instead of default params
      def self.signature(params)
        params['expires'] ||= (Time.now.to_i + 10).to_s
        string_to_sign = params.keys.sort.inject(@secret) do |memo, key|
          HTTP.default_params key => params[key]
          memo += "#{key}=#{params[key]}"
        end
        digest = Digest::SHA256.digest(string_to_sign)
        Base64::encode64(digest).chomp.gsub(/=+$/, '')
      end

    end

  end
end

