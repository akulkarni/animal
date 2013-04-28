class RecordController < ApplicationController

  # BIG TASKS
  # Text me every day at 8pm, with a varied message
  # Record the message and the response, encrypted
  # Send me an email on Sunday morning with my musings for that week
  # Also display messages on a page (?)

  # TODO
  # Register page, endpoint, store salted passwords
  # Set up rake task, scheduler
  # Encrypt, decrypt messages?

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

    user = RecordUsers.where(:phone_number => phone_number).last unless phone_number.nil?
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
