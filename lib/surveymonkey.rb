require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Surveymonkey < OmniAuth::Strategies::OAuth2

      DEFAULT_RESPONSE_TYPE = 'code'

      option :name, "surveymonkey"

      option :client_options, {
        :site => "https://api.surveymonkey.com",
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token'
      }

      option :authorize_options, [:client_id, :api_key]

      def authorize_params
        super.tap do |params|
          params[:response_type] ||= DEFAULT_RESPONSE_TYPE
          params[:client_id] = options[:client_id]
          params[:api_key] = options[:api_key]
        end
      end
      
      def callback_phase
        options[:client_options][:token_url] = "/oauth/token?api_key=#{options[:api_key]}"
        super
      end

    end
  end
end