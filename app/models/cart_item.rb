class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
    
  validates :amount, presence: { message: "は必須項目です。" }, numericality: { message: "は数値が必要です。" }
end
