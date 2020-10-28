class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_items
  belongs_to :category
  
  attachment :image

  validates :name, presence: true
  validates :image, presence: true
  validates :description, presence: true
  validates :price, numericality: true
  validates :is_active, inclusion: { in: [true, false] }

  scope :by_name, ->(keyword){ where("name LIKE ?", "%#{keyword}%") }

  def price_with_tax
    (self.price * 1.1).floor
  end

  def status
    if is_active
     "販売中"
    else
      "販売中止"
    end
  end

end
