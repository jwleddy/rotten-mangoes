class User < ActiveRecord::Base

  has_secure_password
  paginates_per 10

  has_many :reviews, dependent: :destroy
  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :password, length: { in: 6..20 }, on: :create

  def full_name
    "#{firstname.capitalize} #{lastname.capitalize}"
  end

end
