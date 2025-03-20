require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)  # ユーザー作成
    @item = FactoryBot.create(:item)  # 商品作成
    @order_shipping = FactoryBot.build(:order_shipping, user_id: @user.id, item_id: @item.id)
  end

  describe '購入情報の保存' do
    context '購入情報が保存される場合' do
      it '全ての情報が正しく入力されていれば保存できる' do
        expect(@order_shipping).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
    end

    context '購入情報が保存されない場合' do
      it 'クレジットカード情報(token)が空では保存できない' do
        @order_shipping.token = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が正しい形式でないと保存できない' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it '都道府県が空では保存できない' do
        @order_shipping.prefecture_id = 1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では保存できない' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では保存できない' do
        @order_shipping.address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では保存できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁または11桁でないと保存できない' do
        @order_shipping.phone_number = '09012345'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号にハイフンが含まれていると保存できない' do
        @order_shipping.phone_number = '090-1234-5678'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid")
      end

      it 'ユーザーが紐付いていないと保存できない' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end

      it '商品が紐付いていないと保存できない' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end