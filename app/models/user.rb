class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  has_many :posts
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: 'post'

  def favorited_by?(post_id)
    favorites.where(post_id: post_id).exists?
  end
end
