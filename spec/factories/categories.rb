FactoryBot.define do
  factory :category1, class: Category do
    name { "ケーキ" }
    is_active { true }
  end
  factory :category2, class: Category do
    name { "焼き菓子" }
    is_active { true }
  end
  factory :category3, class: Category do
    name { "プリン" }
    is_active { true }
  end
  factory :category4, class: Category do
    name { "キャンディ" }
    is_active { true }
  end
end