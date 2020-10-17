require 'rails_helper'

RSpec.describe "Orders", type: :system do
  describe "about order page" do
    let(:customer1){ create(:customer1) }
    let(:category1){ create(:category1) }
    let(:category2){ create(:category2) }
    let(:item1){ create(:item1, category: category1) }
    let(:item2){ create(:item2, category: category2) }
    before do
      visit new_customer_session_path
      fill_in "customer[email]", with: customer1.email
      fill_in "customer[password]", with: customer1.password
      click_button "ログイン"
      @cart_item1 = customer1.cart_items.create(item: item1, amount: 3)
      @cart_item2 = customer1.cart_items.create(item: item2, amount: 2)
    end
    context "on order-new page" do
      before do
        visit new_order_path
      end
      it "has '注文情報入力'" do
        expect(page).to have_content "注文情報入力"
      end
      it "has radio-button for how_to_pay" do
        expect(page).to have_content "支払方法"
        expect(page).to have_field "order[how_to_pay]", with: "クレジットカード"
        expect(page).to have_field "order[how_to_pay]", with: "銀行振込" 
      end
      it "has radio-button for where to deliver" do
        # expect(page).to have_content "お届け先"
        # expect(page).to have_
      end
      it "has button to order-log page" do
        expect(page).to have_button "確認画面へ進む"
      end
    end
    context "on order-log page" do
      before do
        @order = customer1.orders.new(
          deliver_postcode: customer1.postcode,
          deliver_address: customer1.address,
          deliver_name: customer1.name,
          deliver_fee: 800
        )
        @order.set_order_items
        @order.total_price = @order.set_total_price
        visit orders_log_path
      end
      it "has '注文情報確認'" do
        expect(page).to have_content "注文情報確認"
      end
      it "has table-heading for items" do
        expect(page).to have_content "商品名"
        expect(page).to have_content "単価(税込)"
        expect(page).to have_content "数量"
        expect(page).to have_content "小計"
        expect(page).to have_content "送料"
        expect(page).to have_content "商品合計"
        expect(page).to have_content "請求金額"
      end
      it "has info for order_items" do
        @order.order_items.each do |order_item|
          expect(page).to have_content order_item.item.name
          expect(page).to have_contemnt order_item.price
          expect(page).to have_content order_item.amount
          expect(page).to have_content order_item.subtotal
        end
        expect(page).to have_content @order.deliver_fee
        expect(page).to have_content @order.total_price
        expect(page).to have_content @order.whole_total_price
      end
      it "has info for how_to_pay" do
        expect(page).to have_content "支払方法"
        expect(page).to have_content @order.how_to_pay
      end
      it "has info for where to deliver" do
        expect(page).to have_content "お届け先"
        expect(page).to have_content @order.deliver_postcode
        expect(page).to have_content @order.deliver_address
        expect(page).to have_content @order.deliver_name
      end
      it "has button '購入を確定する'" do
        expect(page).to have_button "購入を確定する"
      end
      it "succeeds to make a new order" do
        click_button "購入を確定する"
        expect(current_path).to eq orders_thanks_path
      end
    end
  end
end
