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
               "What's up?",
               "What was the most important thing you did today?",
               "What's your biggest regret of today?",
               "What conversation today do you remember the most?",
               "Dude.",
               "Hit me.",
               "What's new?",
               "Who's someone that's close to you, but with whom you haven't spoken in a while? Call them right now.",
               "Are you happy?",
               "What are you doing really poorly, that you could do better?",
               "It's about that time."
              ]

end
