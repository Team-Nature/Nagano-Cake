FactoryBot.define do 
  factory :customer1, class: Customer do
    last_name { "岸" }
    first_name { "優" }
    last_name_kana { "きし" }
    first_name_kana { "ゆう" }
    email { "yuki@com" }
    password { "testtest" }
    password_confirmation { "testtest" }
    postcode { "1111111" }
    address { "滋賀県" }
    tel { "01234567890" }
    is_active { true }
  end
end