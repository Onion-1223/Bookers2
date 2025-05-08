class Book < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :title, presence: true
  validates :body, presence: true,length: {maximum:200}
end