class RecordController < ApplicationController

  # BIG TASKS
  # Text me every day at 8pm, with a varied message
  # Record the message and the response, encrypted
  # Send me an email on Sunday morning with my musings for that week
  # Also display messages on a page (?)

  # TODO
  # Have random string of messages to choose from
  # Send welcome text and first message to user on registration
  # Allow user to see their encrypted and decrypted messages on web

  def index
    render :text => 'OK'
  end

  def signup
  end

  def register
    name = params['name']
    email = params['email']
    phone_number = params['phone_number']
    password = params['password']

    unless name.blank? or email.blank? or phone_number.blank? or password.blank?
      user = RecordUser.new(:name => name,
                            :email => email,
                            :phone_number => '+%s' % phone_number,
                            :password => password)
      user.save
      # do something, text user?
      response = 'SUCCESS!'
    else
      response = "Something's missing."
    end

    render :text => response
  end

  def login
    user = RecordUser.authenticate('ajayx@acoustik.org', 'ballsx')
    render :json => user
  end

  def send_nudge
    question = DailyQuestion.where("date(created_at) = '%s'" % Date.today.to_s).last
    if question.nil?
      question = DailyQuestion.new
      question.save!
    end
    
    users = RecordUser.all
    users.each do |u|
      send_sms(u.phone_number, question.message)
    end

    render :text => 'OK'
  end

  def receive_sms
    sms_body = params['Body']
    phone_number = params['From']

    user = RecordUser.where(:phone_number => phone_number).last unless phone_number.nil?
    user.add_record(sms_body) unless user.nil?

    render :text => 'OK'
  end

  def send_sms(phone_number, text)
    client = get_twilio_client
    client.account.sms.messages.create(:from => ENV['RECORD_TWILIO_NUMBER'],
                                       :to => phone_number,
                                       :body => text[0...160])
  end

  def get_twilio_client
    return Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

end
