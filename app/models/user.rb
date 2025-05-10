class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         validates :name, uniqueness: true,presence: true, length: { minimum:2,maximum:20 }
         validates :password, presence: true, length: { minimum: 6 }, on: :create
         validates :password, length: { minimum: 6 }, allow_blank: true, on: :update
         validates :introduction,length: {maximum:50}

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  
  def get_profile_image(width = 100, height = 100)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end