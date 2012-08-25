class User < ActiveRecord::Base
  attr_accessible :email

  has_one :company

  validates_presence_of :email
  validates_format_of :email, :with =>  /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
  validates_uniqueness_of :email

  def self.login email, password
    user = User.where(email: email).first
    if user
      encripted_pass = Digest::SHA1.hexdigest("--#{password}--")
      return false if user.password != encripted_pass
    else
      user = User.new email: email
      user.plain_password = password
      user.save
      return nil unless user.valid?
    end
    user
  end

  def plain_password= password
    self.password = Digest::SHA1.hexdigest("--#{password}--")
  end

end
