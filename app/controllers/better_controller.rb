class BetterController < ApplicationController

  # TODO
  # check in on foursquare,
  #  text me to ask how it went
  #  display results on a page

  OAUTH_URI = 'https://foursquare.com/oauth2/authenticate?client_id=%s&response_type=code&redirect_uri=%s/redirect'
  ACCESS_TOKEN_URI = 'https://foursquare.com/oauth2/access_token?client_id=%s&client_secret=%s&grant_type=authorization_code&redirect_uri=%s/redirect&code=%s' 

  def index
    username = params['username']
    username = load_from_cookies(:username) if username.nil?

    unless username.nil? 
      save_to_cookies(:username, username.downcase)
      user = FoursquareUser.where(:username => username.downcase).last 
      unless user.nil?
        # do shit here.
        send_sms(user.phone_number) 
        render :text => 'O-KAY!'
      else
        render :text => 'Please register first.'
      end
    else
      render :text => 'missing username.'
    end
  end

  def register
    username = params['username']
    phone_number = params['phone_number']
    unless username.nil? or phone_number.nil?
      save_to_cookies(:username, username)
      save_to_cookies(:phone_number, '+' + phone_number)
      user = FoursquareUser.where(:username => username.downcase).last
      if user.nil?
        return oauth
      else
        render :text => 'username already exists.'
      end
    else
      render :text => 'missing username or phone_number.'
    end
  end

  def send_sms(phone_number)
    client = get_twilio_client
    client.account.sms.messages.create(:from => '+19123883779',
                                        :to => phone_number,
                                        :body => 'Nice workout. How did it go?')
  end

  def receive_sms
    sms_body = params['Body']
    phone_number = params['From']

    user = FoursquareUser.where(:phone_number => phone_number).last
    unless user.nil?
      log = WorkoutLog.new(:user_id => user.id, :feedback => sms_body)
      log.save!
    end
  end

  def get_twilio_client
    return Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

  def oauth
    oauth_uri = OAUTH_URI % [ENV['FOURSQUARE_BETTER_CLIENT_ID'], ENV['BETTER_HOST']]
    redirect_to oauth_uri
  end

  def redirect
    code = params['code']
    access_token_uri = ACCESS_TOKEN_URI % [ENV['FOURSQUARE_BETTER_CLIENT_ID'], ENV['FOURSQUARE_BETTER_CLIENT_SECRET'], ENV['BETTER_HOST'], code]

    response = Typhoeus.get(access_token_uri)
    access_token = JSON.parse(response.body)['access_token']
    username = load_from_cookies(:username)
    phone_number = load_from_cookies(:phone_number)

    unless access_token.nil? or username.nil?
      user = FoursquareUser.new(:username => username.downcase, 
                                :phone_number => phone_number, 
                                :access_token => access_token)
      user.save!
      redirect_to ENV['BETTER_HOST']
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
