class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_items
  belongs_to :category
    
  validates :name, presence: true
  validates :image_id, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: true
  validates :is_active, presence: true, inclusion: { in: [true, false] }
    
end
