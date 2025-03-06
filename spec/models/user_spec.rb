require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての情報が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        expect(@user).to be_invalid
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        expect(@user).to be_invalid
      end

      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'testexample.com'
        expect(@user).to be_invalid
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        expect(another_user).to be_invalid
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        expect(@user).to be_invalid
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = @user.password
        expect(@user).to be_invalid
      end

      it 'passwordが半角英数字混合でないと登録できない(数字のみ)' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        expect(@user).to be_invalid
      end

      it 'passwordが半角英数字混合でないと登録できない(英字のみ)' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        expect(@user).to be_invalid
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password_confirmation = 'different123'
        expect(@user).to be_invalid
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        expect(@user).to be_invalid
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.last_name = 'Smith'
        expect(@user).to be_invalid
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        expect(@user).to be_invalid
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.first_name = 'John'
        expect(@user).to be_invalid
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        expect(@user).to be_invalid
      end

      it 'last_name_kanaが全角カタカナ以外では登録できない' do
        @user.last_name_kana = 'やまだ'
        expect(@user).to be_invalid
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        expect(@user).to be_invalid
      end

      it 'first_name_kanaが全角カタカナ以外では登録できない' do
        @user.first_name_kana = 'たろう'
        expect(@user).to be_invalid
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        expect(@user).to be_invalid
      end
    end
  end
end