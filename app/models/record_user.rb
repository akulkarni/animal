class RecordUser < ActiveRecord::Base
  attr_accessible :email, :name, :password, :phone_number, :username

  def add_record(message)
    user_id = read_attribute(:id)
    puts 'user_id: %s' % user_id
    unless user_id.nil?
      latest_question = DailyQuestion.last
      puts latest_question.as_json
      record = DailyRecord.new(:user_id => user_id,
                               :message => message,
                               :question_message => latest_question.message)
      record.save! 
    end
  end
end
