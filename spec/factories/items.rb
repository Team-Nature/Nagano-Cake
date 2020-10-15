FactoryBot.define do
  factory :item1, class: Item do
    category_id { 1 }
    name { "イチゴのケーキ" }
    image_id { "image" }
    description { "当店一押し" }
    price { 400 }
    is_active { true }
  end
end
