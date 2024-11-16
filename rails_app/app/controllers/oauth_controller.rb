require "uri"
require "net/http"

# OAuth 2.0
# reference: https://openid-foundation-japan.github.io/rfc6749.ja.html

class OauthController < ApplicationController
  AUTHORIZE_URL = 'http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/authorize'
  OAUTH_TOKEN_URL = 'http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/oauth/token'
  TWEET_URL = 'http://unifa-recruit-my-tweet-app.ap-northeast-1.elasticbeanstalk.com/api/tweets'

  def connect
    params = {
      client_id: Rails.application.credentials.oauth.client_id,
      response_type: 'code',
      redirect_uri: 'http://localhost:3000/oauth/callback',
      scope: 'write_tweet',
    }
    redirect_to "#{AUTHORIZE_URL}?#{params.to_query}", allow_other_host: true
  end

  def callback
    # NOTE assume params[:code] 100% exists
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
    parsed_json = JSON.parse(response.body).symbolize_keys
    # NOTE assume parsed_json[:token] 100% exists
    session[:access_token] = parsed_json[:access_token]
    # TODO remove access_token from user
    # current_user.update! access_token: parsed_json[:access_token]
    redirect_to root_path
  end

  def tweet
    # TODO omitting the situation if find_by return nil
    photo = Photo.find_by!(id: params[:photo_id], user_id: current_user.id)
    post_params = {
      text: photo.title,
      url: photo.image_url,
    }
    uri = URI.parse(TWEET_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer #{session[:access_token]}",
    }
    response = http.post uri.path, post_params.to_json, headers
    # NOTE assume the response is always success
    if response.code == '201'
      flash[:success] = 'ツイート成功'
    else
      flash[:fail] = 'ツイート失敗'
    end
    redirect_to root_path
  end
end
