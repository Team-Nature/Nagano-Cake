class Delivery < ApplicationRecord
  belongs_to :customer
    
  validates :postcode, presence: { message: "は必須項目です。" }
  validates :address, presence: { message: "は必須項目です。" }
  validates :name, presence: { message: "は必須項目です。" }

end
