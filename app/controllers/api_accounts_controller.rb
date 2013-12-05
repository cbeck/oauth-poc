class ApiAccountsController < ApplicationController
  before_filter :find_api_account, :only => [:show, :destroy]

  def index
    @api_accounts = ApiAccount.all
  end

  def new
    @errors = params[:message]    
  end

  def show  
    @response = HTTParty.post("https://api.surveymonkey.net/v2/surveys/get_survey_list",
        :query => {:api_key => ENV['SURVEY_MONKEY_API_KEY']},
        :headers => { "Authorization" => "bearer #{@api_account.oauth_token}", "Content-Type" => "application/json"}
      )  
  end

  def create
    Rails.logger.info "#{auth_hash.inspect}"
    @auth_hash = auth_hash
    @api_account = ApiAccount.find_or_create_by_username(@auth_hash[:info][:client])
    @api_account.oauth_token = @auth_hash[:credentials][:token]
    if @api_account.save
      flash[:message] = "Credentials saved!"
    else
      flash[:message] = "There was a problem saving the credentials."
      render :new
    end
  end

  def destroy
    @api_account.destroy
    redirect_to api_accounts_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def find_api_account
    @api_account = ApiAccount.find(params[:id])
  end
end
