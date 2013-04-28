class DailyQuestion < ActiveRecord::Base
  attr_accessible :message
  before_create :add_message

  def add_message
    write_attribute(:message, get_random_question)
  end
  
  def get_random_question
    return "Ok, let's hear it."
  end
end
