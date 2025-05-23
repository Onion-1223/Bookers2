class Book < ApplicationRecord
  
  belongs_to :user
  validates :user, presence: true
  validates :title, presence: true
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :body, presence: true,length: {maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end