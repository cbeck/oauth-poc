require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Surveymonkey < OmniAuth::Strategies::OAuth2

      DEFAULT_RESPONSE_TYPE = 'code'
      DEFAULT_GRANT = 'authorization_code'

      option :name, "surveymonkey"

      option :client_options, {
        :site => "https://api-surveymonkey-com-fytofsd4ktc2.runscope.net",
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token'
      }

      option :authorize_options, [:client_id, :api_key]

      def authorize_params
        log :info, ">>>>>>>> in authorize_params"
        super.tap do |params|
          params[:response_type] ||= DEFAULT_RESPONSE_TYPE
          params[:client_id] = options[:client_id]
          params[:api_key] = options[:api_key]
        end
      end

      def token_params
        log :info, ">>>>>>> calling token params"
        super.tap do |params|
          params[:grant_type] ||= DEFAULT_GRANT
          params[:client_id] = options[:client_id]
          params[:client_secret] = options[:client_secret]
          params[:redirect_uri] = callback_url
        end
      end

      def build_access_token
        log :info, ">>>>>>>> calling build_access_token"
        verifier = request.params['code']
        log :info, ">>>>>>> code: #{verifier.inspect}"
        log :info, ">>>>> getting auth token now"
        token = client.auth_code.get_token(verifier, token_params)
        log :info, ">>>>>> token: #{token.inspect}"
        token
      end
      
      def callback_phase
        log :info, ">>>>>>>> in callback_phase"
        options[:client_options][:token_url] = "/oauth/token?api_key=#{options[:api_key]}"
        log :info, ">>>> in callback phase, calling build_access_token"
        self.access_token = build_access_token
        log :info, ">>>>>> self access token: #{self.access_token.inspect}"
        log :info, ">>>> getting ready to set auth hash"
        hash = auth_hash
        log :info, ">>>>> auth hash is: #{hash.inspect}"
        self.env['omniauth.auth'] = hash
        log :info, ">>>> calling app"
        call_app!
      end

      info do
        {
          :token => self.access_token.token,
          :client => self.access_token.client.id
        }
      end
    end
  end
end