require 'rails_helper'

RSpec.describe "TestThroughs", type: :system do
  describe "test-through" do
    let(:admin1){ create(:admin1) }
    context "through" do
      it "through" do
        # マスタ登録
        
        # 1. メールアドレス・パスワードでログインする
        visit new_admin_session_path
        fill_in "admin[email]", with: admin1.email
        fill_in "admin[password]", with: admin1.password
        click_button "ログイン"
        
        # 2. ヘッダからジャンル一覧へのリンクを押下する
        click_link "ジャンル一覧", href: new_admin_categories_path
        expect(current_path).to eq new_admin_category_path

        # 3. 必要事項を入力し、登録ボタンを押下する
        fill_in "category[name]", with: "チョコレート"
        choose "有効"
        click_button "追加"
        expect(current_path).to eq new_admin_category_path
        expect(page).to have_content "チョコレート"
        
        # 4. ヘッダから商品一覧へのリンクを押下する
        click_link "商品一覧", href: admin_items_path
        expect(current_path).to eq admin_items_path
        
        # 5. 新規登録ボタンを押下する
        click_link "", href: admin_new_item_path
        expect(current_path).to eq admin_new_itme_path
        
        # 6. 商品新規登録画面
        # attach_file "チョコレート", ""
        fill_in "item[name]", with: "ちょこっとチョコレート"
        fil_in "item[description]", with: "小腹が空いたときに！"
        select "チョコレート", from: "item[cagetory]"
        fill_in "item[price]", with: 350
        select "販売中", from: item[is_active]
        click_button "新規登録"
        # expect(current_path).to eq admin_item_path
        expect(page).to have_content "ちょこっとチョコレート"
        
        # 7. ヘッダから商品一覧へのリンクを押下する
        click_link "商品一覧", href: admin_items_path
        
        # 8. -
        expect(current_path).to eq admin_items_path
        
        # 9. 新規登録ボタンを押下する(2商品目)
        click_link "", href: new_admin_item_path
        expect(current_path).to eq new_admin_item_path
        
        # 10. 必要事項を入力して登録ボタンを押下する
        fill_in "item[name]", with: "背筋も凍るアイスキャンディ"
        fil_in "item[description]", with: "うだるような暑さに"
        select "キャンディ", from: "item[cagetory]"
        fill_in "item[price]", with: 220
        select "販売中", from: item[is_active]
        # expect{ click_button "新規登録" }.to change(Item.all.count).by(1)
        # expect(current_path).to eq admin_item_path
        expect(page).to have_content "背筋も凍るアイスキャンディ"

        # 11. ヘッダから商品一覧へのリンクを押下する
        click_link "商品一覧", href: admin_items_path
        expect(current_path).to eq admin_items_path
        
        # 12. - 
        expect(page).to have_content "背筋も凍るアイスキャンディ"
        
        # 13. ヘッダからログアウトボタンをクリックする
        click_link "ログアウト", href: destroy_admin_session_path
        expect(current_path).to eq root_path
        
        # 登録～注文
        # 1. 新規登録画面へのリンクを押下する
        visit root_path
        click_link "新規登録", href: new_customer_registration_path
        expect(current_path).to eq new_customer_registratoin_path
        
        # 2. 必要事項を入力して登録ボタンを押下する
        fill_in "customer[last_name]", with: "市"
        fill_in "customer[first_name]", with: "那"
        fill_in "customer[last_name_kana]", with: "いち"
        fill_in "customer[first_name_kana]", with: "な"
        fill_in "customer[email]", with: "ichi@com"
        fill_in "customer[postcode]", with: "1111111"
        fill_in "customer[address]", with: "滋賀県"
        fill_in "customer[tel]", with: "01234567890"
        fill_in "customer[password]", with: "testtest"
        fill_in "customer[password_confirmation]", with: "testtest"
        click_button "新規登録"
        # expect(current_path).to eq items_path 
        
        # 3. ヘッダがログイン用
        expect(page).to have_content "ようこそ、市 那様！"
        expect(page).to have_link "マイページ", href: customer_path
        expect(page).to have_link "商品一覧", href: items_path
        expect(page).to have_link "カート", href: cart_items_path
        expect(page).to have_link "ログアウト", href: destroy_customer_session_path
        
        # 4. 任意の商品画像を押下する
        @item1 = Item.all.first
        @item2 = Item.all.second
        expect(page).to have_content @item1.name
        expect(page).to have_content @item2.name
        click_link "", href: item_path(@item1)
        expect(current_path).to eq item_path(@item1)
        
        # 5. 商品情報が正しく表示されている
        expect(page).to have_content @item1.name
        expect(page).to have_content @item1.description
        expect(page).to have_content @item1.image
        expect(page).to have_button "カートに入れる"  
      end
    end
  end
end