class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true  
  validates :price, presence: true 
  has_many :orders
  
  has_one_attached :photo
  
  def thumbnail
      photo.variant(resize_to_limit: [150, 150]).processed
  end


end
