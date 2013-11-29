class ApiAccountController < ApplicationController
  def index
    @api_accounts = ApiAccount.all
  end

  def new
    @api_account = ApiAccount.new
    @auth_hash = auth_hash
    @errors = params[:message]
  end

  def edit
  end

  def show
    @api_account = ApiAccount.find(params[:id])
  end

  def update
  end

  def create
    # @api_account = ApiAccount.new(params[:api_account])
    # client = Oauth2::Client.new(ENV['SURVEY_MONKEY_CLIENT_ID'], ENV['SURVEY_MONKEY_SECRET'], ENV['SURVEY_MONKEY_API_URL'])
    # client.auth_code.authorize_url(:redirect_uri => 'http://beck-oauth-poc.herokuapp.com/oauth2/callback')

    # token = client.auth_code.get_token('code', :redirect_uri => 'http://beck-oauth-poc.herokuapp.com/oauth2/callback', :headers => {'Authorization' => })

  end

  def destroy
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
