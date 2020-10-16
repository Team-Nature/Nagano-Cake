class Order < ApplicationRecord
  enum how_to_pay: { "クレジットカード": 0, "銀行振込": 1 }
  enum status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }
  
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  
  validates :deliver_postcode, presence: true
  validates :deliver_address, presence: true
  validates :deliver_name, presence: true
  validates :deliver_fee, presence: true, numericality: true
  validates :total_price, presence: true, numericality: true
  validates :how_to_pay, presence: true, inclusion: { in: ["クレジットカード", "銀行振込"] }
  validates :status, presence: true, inclusion: { in: ["入金待ち", "入金確認", "製作中", "発送準備中", "発送済み"] }
  
  def set_order_items
    self.customer.cart_items.each do |cart_item|
      order_item = self.order_items.new
      order_item.item = cart_item.item
      order_item.amount = cart_item.amount
      order_item.price = cart_item.item.price * 1.1
      order_item.save
    end
  end
end
