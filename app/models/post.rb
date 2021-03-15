class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  validates :museum_name, presence: true
  validates :prefecture_id, presence: true
  validates :rating, presence: true
  validates :image, presence: true

  validates :prefecture_id, presence: true, numericality: { other_than: 1 }
end
