class DailyQuestion < ActiveRecord::Base
  attr_accessible :message
  before_create :add_message

  def add_message
    write_attribute(:message, get_random_question)
  end
  
  def get_random_question
    return QUESTIONS.sample
  end

  QUESTIONS = ["Ok, let's hear it.",
               "How'd it go today?",
               "Imagine today was a color. What color would it be?",
               "What are you up to? Like, RIGHT NOW.",
               "Good day?",
               "You have fun today?",
               "Spill it.",
               "Today: good, bad, or ugly?",
               "If you were to relive today, what would you do differently?",
               "What's up?"
              ]

end
