class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_items
  belongs_to :category
    
  validates :name, presence: { message: "は必須項目です。" }
  validates :image_id, presence: { message: "は必須項目です。" }
  validates :description, presence: { message: "は必須項目です。" }
  validates :price, presence: { message: "は必須項目です。" }, numericality: { message: "は数値が必要です。" }
  validates :is_active, inclusion: { in: [true, false] }
    
end
