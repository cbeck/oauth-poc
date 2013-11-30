SETUP_PROC = lambda do |env| 
  env['omniauth.strategy'].options[:client_id] = ENV['SURVEY_MONKEY_CLIENT_ID']
  env['omniauth.strategy'].options[:api_key] = ENV['SURVEY_MONKEY_API_KEY']
  env['omniauth.strategy'].options[:client_secret] = ENV['SURVEY_MONKEY_SECRET']
  env['omniauth.strategy'].options[:client_options][:site] = 'https://api-surveymonkey-com-fytofsd4ktc2.runscope.net'
end
   


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :surveymonkey, :setup => SETUP_PROC
end

OmniAuth.config.logger = Rails.logger