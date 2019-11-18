class User < ActiveRecord::Base
  has_secure_password
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, :uniqueness => {:case_sensitive => false}
  validates :password, length: { minimum: 3 }
  # validates :email, uniqueness: { scope: :email }, case_sensitive: true
  # validates_uniqueness_of :name, :case_sensitive => false
  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    user && user.authenticate(password.strip)
  end
end
