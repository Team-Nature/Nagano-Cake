class Order < ApplicationRecord
  enum how_to_pay: { "クレジットカード": 0, "銀行振込": 1 }
  enum status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }
  
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  
  validates :deliver_postcode, presence: true
  validates :deliver_address, presence: true
  validates :deliver_name, presence: true
  validates :deliver_fee, numericality: true
  validates :total_price, numericality: true
  validates :how_to_pay, presence: true, inclusion: { in: ["クレジットカード", "銀行振込"] }
  validates :status, presence: true, inclusion: { in: ["入金待ち", "入金確認", "製作中", "発送準備中", "発送済み"] }
  
  scope :today, ->(){ where("created_at >= ?", Date.today).order(id: :desc) }
  
  def set_order_items
    self.customer.cart_items.each do |cart_item|
      order_item = self.order_items.new
      order_item.item = cart_item.item
      order_item.amount = cart_item.amount
      order_item.price = cart_item.item.price * 1.1
      order_item.save
    end
  end
  
  def get_total_price
    total_price = 0
    self.order_items.each do |item|
      subtotal = item.amount * item.price
      total_price += subtotal
    end
    self.total_price = total_price
  end
  
  def get_whole_total_price
    self.total_price + self.deliver_fee
  end
  
  def count_items
    count = 0
    self.order_items.each do |item|
      count += item.amount
    end
    count
  end
end cd