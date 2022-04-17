class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   attachment :user_image

  validates :nickname, presence: true
  #validates :user_image, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :self_introduction, presence: true
  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true
  validates :age, presence: true
  validates :height, presence: true


  has_many :items, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users
  has_many :addresses, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
   has_many :orders, dependent: :destroy

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("nickname LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("nickname LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("nickname LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("nickname LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

end
