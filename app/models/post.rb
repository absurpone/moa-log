class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  validates :museum_name, presence: true
  validates :prefecture_id, presence: true
  validates :rating, presence: true
  validates :image, presence: true

  validates :prefecture_id, presence: true, numericality: { other_than: 1 }

  def self.search(search)
    if search != ""
      Post.where(['museum_name LIKE(?) OR exhibition_title LIKE(?) OR impressive_artist LIKE(?) OR impressive_work LIKE(?) OR text LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Post.all
    end
  end

  def self.search_hokkaido_tohoku
    Post.where(prefecture_id: 2..8)
  end

  def self.search_kanto
    Post.where(prefecture_id: 9..15)
  end
  
  def self.search_chubu
    Post.where(prefecture_id: 16..25)
  end

  def self.search_kinki
    Post.where(prefecture_id: 26..31)
  end

  def self.search_chugoku_shikoku
    Post.where(prefecture_id: 32..40)
  end

  def self.search_kyusyu_okinawa
    Post.where(prefecture_id: 41..48)
  end
end
