class SurveyMonkeyService
  BASE_API_URL = "https://api-surveymonkey-net-fytofsd4ktc2.runscope.net"

  def init(token)
    @token = token
  end

  def make_request(endpoint, data)
    HTTParty.post("#{BASE_API_URL}#{endpoint}",
        :query => {:api_key => ENV['SURVEY_MONKEY_API_KEY']},
        :body => JSON.dump(data),
        :headers => { "Authorization" => "Bearer #{@token}", "Content-Type" => "application/json"}
      )  
  end

  def get_survey_list(data)
    make_request("/v2/surveys/get_survey_list", data)
  end
end