class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :username, uniqueness: true
  validates :password, on: :create, length: {minimum:5} 
end