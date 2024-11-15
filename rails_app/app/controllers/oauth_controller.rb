require "uri"
require "net/http"
# reference: https://openid-foundation-japan.github.io/rfc6749.ja.html
class OauthController < ApplicationController
  def connect
    params = {
      client_id: Rails.application.credentials.oauth.client_id,
      response_type: 'code',
      redirect_uri: 'http://localhost:3000/oauth/callback',
      scope: 'write_tweet',
    }
    redirect_to "http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/authorize?#{params.to_query}", allow_other_host: true
  end

  def callback
    if params[:code]
      # reference: https://stackoverflow.com/questions/1195962/submit-post-data-from-controller-to-another-website-in-rails
      # reference: https://stackoverflow.com/questions/20768518/ruby-post-data-to-a-url
      post_params = {
        client_id: Rails.application.credentials.oauth.client_id,
        client_secret: Rails.application.credentials.oauth.client_secret,
        redirect_uri: 'http://localhost:3000/oauth/callback',
        grant_type: 'authorization_code',
        code: params[:code],
      }
      response = Net::HTTP.post_form(URI.parse('http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token'), post_params)
      parsed_json = JSON.parse(response.body)
      render plain: parsed_json
      # TODO save token to user_token table
    else
      # TODO raise error
    end
  end
end