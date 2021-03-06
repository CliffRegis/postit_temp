class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable
  
  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 10}
  validates :url, presence: true

  def total_votes
    self.vote_up - self.vote_down
  end

  def vote_up
    self.votes.where(vote: true).size
  end
  
  def vote_down
    self.votes.where(vote: false).size
  end
end
