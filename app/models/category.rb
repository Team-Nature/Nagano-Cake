class Category < ApplicationRecord
    has_many :items
    
    validates :name, presence: true
    validates :is_active, presence: true, inclusion: { in: [true, false] }
end
