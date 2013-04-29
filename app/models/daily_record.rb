class DailyRecord < ActiveRecord::Base
  attr_accessible :user_id, :question_message, :plaintext_message
  attr_accessor :plaintext_message
  before_save :encrypt_message

  def encrypt_message
    user = RecordUser.find_by_id(self.user_id)
    if user
#      puts 'hash: %s' % user.password_hash
#      encryptor = ActiveSupport::MessageEncryptor.new(user.password_hash)
#      self.message = encryptor.encrypt_and_sign(plaintext_message)
#      puts encryptor.encrypt_and_sign(plaintext_message)
      self.message = plaintext_message
    end
  end

  def decrypt_message
    user = RecordUser.find_by_id(self.user_id)
    if user
      encryptor = ActiveSupport::MessageEncryptor.new(user.password_hash)
      return encryptor.decrypt_and_verify(self.message)
    else
      return nil
    end
  end                                                

end
