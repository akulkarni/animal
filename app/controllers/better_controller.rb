class BetterController < ApplicationController

  # TODO
  # check in on foursquare,
  #  text me to ask how it went
  #  display results on a page

  # FIX OAUTH
  #   doesn't seem to return access_token to redirect_uri
  #   use cookies for user instead of query string param

  OAUTH_URI = 'https://foursquare.com/oauth2/authenticate?client_id=%s&response_type=code&redirect_uri=%s/redirect/%s'
  ACCESS_TOKEN_URI = 'https://foursquare.com/oauth2/access_token?client_id=%s&client_secret=%s&grant_type=authorization_code&redirect_uri=%s/redirect/%s&code=%s' 

  def index
    username = params['username']
    unless username.nil?
      user = FoursquareUser.where(:username => username.downcase).last 
      if user.nil?
        return oauth(username)
      else
        access_token = user.access_token
      end
    end

    render :text => 'O-KAY!'
  end

  def oauth(username)
    oauth_uri = OAUTH_URI % [ENV['FOURSQUARE_BETTER_CLIENT_ID'], ENV['BETTER_HOST'], username]
    puts oauth_uri
    redirect_to oauth_uri
  end

  def redirect
    username = params['username']
    code = params['code']

    access_token_uri = ACCESS_TOKEN_URI % [ENV['FOURSQUARE_BETTER_CLIENT_ID'], ENV['FOURSQUARE_BETTER_CLIENT_SECRET'], ENV['BETTER_HOST'], username, code]
    puts access_token_uri

    response = Typhoeus.get(access_token_uri)
    access_token = response['access_token']
    unless access_token.nil?
      user = FoursquareUser.new(:username => username.downcase, :access_token => access_token)
      user.save!
      redirect_to '%s/index?username=%s' % [ENV['BETTER_HOST'], username]
    else
      render :text => 'something bad happened.'
    end
  end
end
