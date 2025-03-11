require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item) # FactoryBot で Item のテストデータを作成
  end

  describe '商品出品' do
    context '出品が成功する場合' do
      it '全ての情報が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品が失敗する場合' do
      it '商品名が空では出品できない' do
        @item.name = ''
        expect(@item).not_to be_valid
      end

      it '商品の説明が空では出品できない' do
        @item.description = ''
        expect(@item).not_to be_valid
      end

      it 'カテゴリーの情報が空では出品できない' do
        @item.category_id = 1 # `1` は `---` なので無効
        expect(@item).not_to be_valid
      end

      it '商品の状態の情報が空では出品できない' do
        @item.status_id = 1
        expect(@item).not_to be_valid
      end

      it '配送料の負担の情報が空では出品できない' do
        @item.shipping_fee_id = 1
        expect(@item).not_to be_valid
      end

      it '発送元の地域の情報が空では出品できない' do
        @item.prefecture_id = 1
        expect(@item).not_to be_valid
      end

      it '発送までの日数の情報が空では出品できない' do
        @item.delivery_day_id = 1
        expect(@item).not_to be_valid
      end

      it '価格の情報が空では出品できない' do
        @item.price = nil
        expect(@item).not_to be_valid
      end

      it '価格が300円未満では出品できない' do
        @item.price = 299
        expect(@item).not_to be_valid
      end

      it '価格が9,999,999円を超えると出品できない' do
        @item.price = 10_000_000
        expect(@item).not_to be_valid
      end

      it '価格が半角数字でない場合、出品できない' do
        @item.price = '１０００'
        expect(@item).not_to be_valid
      end

      it 'ユーザーが紐付いていないと出品できない' do
        @item.user = nil
        expect(@item).not_to be_valid
      end

      it '商品画像が空では出品できない' do
        @item.image = nil
        expect(@item).not_to be_valid
      end
    end
  end
end