require 'rails_helper'

RSpec.describe "AdminCategories", type: :system do
  describe "about category" do
    let(:admin1){ create(:admin1) }
    let(:category1){ create(:category1) }
    let(:category2){ create(:category2) }
    let(:item1) { create(:item1) }
    let(:item2) { create(:item2) }
    before do
      visit new_admin_session_path
      fill_in "admin[email]", with: admin1.email
      fill_in "admin[password]", with: admin1.password
      click_button "ログイン"
    end
    context "on new page" do
      before do
        visit new_admin_category_path
      end
      it "has 'ジャンル一覧・追加" do
        expect(page).to have_content "ジャンル一覧・追加"
      end
      it "has category_form to add" do
        expect(page).to have_field "category[name]"
        expect(page).to have_css "category_is_active_true"
        expect(page).to have_css "category_is_active_false"
        expect(page).to have_button "追加"
      end
      it "has category-table-header" do
        expect(page).to have_content "ジャンル"
        expect(page).to have_content "状態"
      end
      it "has categories and button to edit" do
        Category.all do |category|
          expect(page).to have_content cateory.name
          expect(page).to have_content category.status
          expect(pave).to have_link "編集する", href: edit_admin_category_path(category)
        end
      end
    end
    context "on category edit page" do
      before do
        visit edit_admin_category_path(category1)
      end
      it "has 'ジャンル編集'" do
        exepct(page).to have_content "ジャンル編集"
      end
      it "has form for editing category" do
        expect(page).to have_field "category[name]"
        expect(page).to have_css "category_is_active_true"
        expect(page).to have_css "category_is_active_false"
        expect(page).to have_ss "変更を保存する"
      end
    end
  end
end
