class Category < ApplicationRecord
  has_many :items
    
  validates :name, presence: { message: "は必須項目です。" }
  validates :is_active, inclusion: { in: [true, false] }
    
  def status
    if self.is_active
      "有効"
    else
      "無効"
    end
  end
end
