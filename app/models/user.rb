class User < ActiveRecord::Base
  attr_accessible :password, :username
  validate :username, :presence => true, :uniqueness => true
  validate :password, :presence => true

  def reset_session_token
    self.token = SecureRandom.base64(16)
    self.save!
    self.token
  end

end
