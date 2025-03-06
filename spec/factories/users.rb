FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name } # ニックネームをFakerでランダム生成
    email { Faker::Internet.unique.email } # 一意のメールアドレスを生成
    password { 'a1b2c3' } # 半角英数字混合の6文字以上のパスワードを固定値で設定
    password_confirmation { password } # passwordと一致させる
    last_name { '山田' } # 全角の名字（バリデーション対応）
    first_name { '太郎' } # 全角の名前（バリデーション対応）
    last_name_kana { 'ヤマダ' } # 全角カナの名字
    first_name_kana { 'タロウ' } # 全角カナの名前
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) } # ランダムな誕生日（18〜65歳）
  end
end