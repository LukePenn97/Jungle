
class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email_to_check, password_to_check)
    user = User.where('lower(email) = ?', email_to_check.downcase.strip).first
    # user = User.find_by_email(email_to_check.downcase.strip)

    p email_to_check.downcase.strip
    if user.authenticate(password_to_check)
      return user
    else
      return nil
    end
  end
end
