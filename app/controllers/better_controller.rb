class BetterController < ApplicationController

  # TODO
  # check in on foursquare,
  #  text me to ask how it went
  #  display results on a page

  # FIX OAUTH
  #   use cookies for user instead of query string param

  OAUTH_URI = 'https://foursquare.com/oauth2/authenticate?client_id=%s&response_type=code&redirect_uri=%s/redirect'
  ACCESS_TOKEN_URI = 'https://foursquare.com/oauth2/access_token?client_id=%s&client_secret=%s&grant_type=authorization_code&redirect_uri=%s/redirect&code=%s' 

  def index
    username = params['username']
    unless username.nil?
      save_to_cookies(:username, username)
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
    oauth_uri = OAUTH_URI % [ENV['FOURSQUARE_BETTER_CLIENT_ID'], ENV['BETTER_HOST']]
    redirect_to oauth_uri
  end

  def redirect
#    username = params['username']
    code = params['code']
    
    access_token_uri = ACCESS_TOKEN_URI % [ENV['FOURSQUARE_BETTER_CLIENT_ID'], ENV['FOURSQUARE_BETTER_CLIENT_SECRET'], ENV['BETTER_HOST'], code]

    response = Typhoeus.get(access_token_uri)
    access_token = JSON.parse(response.body)['access_token']
    username = load_from_cookies(:username)

    unless access_token.nil? or username.nil?
      user = FoursquareUser.new(:username => username.downcase, :access_token => access_token)
      user.save!
      redirect_to '%s?username=%s' % [ENV['BETTER_HOST'], username]
    else
      render :text => 'something bad happened.'
    end
  end

  def save_to_cookies(key, value)
    cookies.delete key unless  cookies[key].nil?
    cookies[key] = {
      :value => Marshal.dump(value),
      :expires => 4.years.from_now
    }
  end
  
  def load_from_cookies(key)
    unless cookies[key].nil?
      return Marshal.load(cookies[key]).as_json
    else
      return nil
    end
  end
end
