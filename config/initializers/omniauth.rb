Rails.application.config.middleware.use OmniAuth::Builder do
  provider :surveymonkey, ENV['SURVEY_MONKEY_CLIENT_ID'], ENV['SURVEY_MONKEY_API_KEY']
end

OmniAuth.config.logger = Rails.logger