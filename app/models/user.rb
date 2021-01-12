class User < ActiveRecord::Base
  
  has_secure_password

  validates :password, presence: true, confirmation: true, length: {minimum: 5}
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :downcase_no_space_email

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user
      if user.authenticate(password)
        user
      else
        nil
      end
    else
      nil
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def downcase_no_space_email
    self.email.downcase!
    self.email.strip!
  end

end
