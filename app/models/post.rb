class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :museum_name, presence: true
  validates :prefecture_id, presence: true
  validates :rating, presence: true
  validates :image, presence: true
end
